//
//  TorchController.h
//  MorseTorch
//
//  Created by Reed Sweeney on 4/16/14.
//  Copyright (c) 2014 Reed Sweeney. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TorchControllerDelegate <NSObject>

@optional
-(void)displayNewLetter:(NSString *)newLetter;

-(void)doneTransmitting;


@end

@interface TorchController : NSObject

@property (nonatomic, weak) id<TorchControllerDelegate> delegate;

-(void)convertToMorseCode:(NSString *)morseString;

-(void)cancelSending;

@end
