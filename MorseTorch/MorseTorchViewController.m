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
#import "TorchController.h"
#import <ProgressHUD/ProgressHUD.h>

@interface MorseTorchViewController () <UITextFieldDelegate, TorchControllerDelegate>

@property (nonatomic, strong) IBOutlet UITextField *textInputField;
@property (nonatomic, weak) NSString *inputText;
@property (nonatomic, strong) NSMutableArray *translatedSymbolsArray;
@property (nonatomic, strong) IBOutlet UIButton *sendButton;
@property (nonatomic, strong) TorchController *torchController;

@end

@implementation MorseTorchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textInputField.delegate = self;
    self.torchController = [[TorchController alloc] init];
    self.torchController.delegate = self;
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
        [self.torchController convertToMorseCode:self.textInputField.text];
    }
}

- (IBAction)cancelButton:(id)sender
{
    [self.torchController cancelSending];
    [self doneTransmitting];
}

-(void)convertMorseCode
{
    self.translatedSymbolsArray = [NSString morseSymbolsForString:self.textInputField.text];
}

-(void)displayNewLetter:(NSString *)newLetter
{
    [ProgressHUD show:newLetter];
}

-(void)doneTransmitting
{
    [ProgressHUD dismiss];
    [self.sendButton setEnabled:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.textInputField isFirstResponder])
    {
        [self.textInputField resignFirstResponder];
    }
}

@end










