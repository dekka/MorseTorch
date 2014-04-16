//
//  MorseTorchViewController.m
//  MorseTorch
//
//  Created by Reed Sweeney on 4/14/14.
//  Copyright (c) 2014 Reed Sweeney. All rights reserved.
//

#import "MorseTorchViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "NSString+MorseCode.h"

@interface MorseTorchViewController () <UITextViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textInputField;
@property (weak, nonatomic) NSString *inputText;
@property (strong, nonatomic) NSMutableArray *translatedSymbolsArray;
@property (weak, nonatomic) AVCaptureDevice *myDevice;
@property (strong, nonatomic) NSOperationQueue *flashQueue;
@property (nonatomic, strong) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *outputField;


@end

@implementation MorseTorchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textInputField.delegate = self;
    
    self.myDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.flashQueue = [NSOperationQueue new];
    
    self.flashQueue.maxConcurrentOperationCount = 1;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self reloadInputViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)sendButton:(id)sender
{
    if (self.textInputField.text.length != 0) {
        [self.sendButton setEnabled:NO];
        [self convertMorseCode];
        
        for (NSString *morseLetter in self.translatedSymbolsArray) {
            for (int i=0; i<morseLetter.length; i++) {
                NSString *morseSymbol = [morseLetter substringWithRange:NSMakeRange(i, 1)];
                if ([morseSymbol isEqualToString:@"."]) {
                    [self.flashQueue addOperationWithBlock:^{
                        [self flashDot];
                    }];
                } else if ([morseSymbol isEqualToString:@"_"]) {
                    [self.flashQueue addOperationWithBlock:^{
                        [self flashDash];
                    }];
                } else if ([morseSymbol isEqualToString:@" "]) {
                    [self.flashQueue addOperationWithBlock:^{
                        [self flashWordSpace];
                    }];
                }
            }
            [self.flashQueue addOperationWithBlock:^{
                [self flashLettersSpace];
            }];
        }
        [self.flashQueue addOperationWithBlock:^{
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                [self.sendButton setEnabled:YES];
                
            }];
        }];
    }
}


- (IBAction)cancelButton:(id)sender
{
    [self.flashQueue performSelector:@selector(cancelAllOperations) withObject:nil afterDelay:1.0];
    [self.sendButton setEnabled:YES];
}

-(void)convertMorseCode
{
    self.translatedSymbolsArray = [NSString morseSymbolsForString:self.textInputField.text];
}


-(void)flashDot
{
    [self.myDevice lockForConfiguration:nil];
    [self.myDevice setTorchMode:AVCaptureTorchModeOn];
    [self.myDevice unlockForConfiguration];
    usleep(100000);
    [self.myDevice lockForConfiguration:nil];
    [self.myDevice setTorchMode:AVCaptureTorchModeOff];
    [self.myDevice unlockForConfiguration];
    usleep(100000);
}

-(void)flashDash
{
    [self.myDevice lockForConfiguration:nil];
    [self.myDevice setTorchMode:AVCaptureTorchModeOn];
    [self.myDevice unlockForConfiguration];
    usleep(300000);
    [self.myDevice lockForConfiguration:nil];
    [self.myDevice setTorchMode:AVCaptureTorchModeOff];
    [self.myDevice unlockForConfiguration];
    usleep(100000);
}

-(void)flashLettersSpace
{
    usleep(200000);
}

-(void)flashWordSpace
{
    usleep(400000);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



@end










