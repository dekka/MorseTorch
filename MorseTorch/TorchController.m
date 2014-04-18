//
//  TorchController.m
//  MorseTorch
//
//  Created by Reed Sweeney on 4/16/14.
//  Copyright (c) 2014 Reed Sweeney. All rights reserved.
//

#import "TorchController.h"
#import <AVFoundation/AVFoundation.h>
#import "NSString+MorseCode.h"

@interface TorchController ()

@property (nonatomic, strong) AVCaptureDevice *myDevice;
@property (nonatomic, strong) NSOperationQueue *flashQueue;


@end

@implementation TorchController

-(id)init
{
    self = [super init];
    if (self) {
        self.myDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        self.flashQueue = [NSOperationQueue new];        
        self.flashQueue.maxConcurrentOperationCount = 1;
    }
    return self;
}

-(void)convertToMorseCode:(NSString *)morseString
{
    NSMutableArray *morseArray = [NSString morseSymbolsForString:morseString];
    
    for (NSString *morseLetter in morseArray)
    {
        [self.flashQueue addOperationWithBlock:^{
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.delegate displayNewLetter:[NSString letterForSymbol:morseLetter]];
            }];
        }];
        for (int i=0; i<morseLetter.length; i++) {
            NSString *morseSymbol = [morseLetter substringWithRange:NSMakeRange(i, 1)];
            if ([morseSymbol isEqualToString:@"."]) {
                [self.flashQueue addOperationWithBlock:^{
                    [self flashDot];
                }];
            } else if ([morseSymbol isEqualToString:@"-"]) {
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
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.delegate doneTransmitting];
        }];
    }];
}

-(void)flashOn
{
    [self.myDevice lockForConfiguration:nil];
    [self.myDevice setTorchMode:AVCaptureTorchModeOn];
    [self.myDevice unlockForConfiguration];
    
}

-(void)flashOff
{
    [self.myDevice lockForConfiguration:nil];
    [self.myDevice setTorchMode:AVCaptureTorchModeOff];
    [self.myDevice unlockForConfiguration];
    
}

-(void)flashDot
{
    [self flashOn];
    usleep(100000);
    [self flashOff];
    usleep(100000);
}

-(void)flashDash
{
    [self flashOn];
    usleep(300000);
    [self flashOff];
    usleep(100000);
}

-(void)flashLettersSpace
{
    //200000 microseconds accounting for 100000 microseconds in flashDot and flashDash
    usleep(200000);
}

-(void)flashWordSpace
{
    //400000 microseconds accounting for flashLettersSpace
    usleep(400000);
}

-(void)cancelSending
{
    [self.flashQueue cancelAllOperations];
}

@end






