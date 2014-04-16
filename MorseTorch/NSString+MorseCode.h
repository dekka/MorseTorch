//
//  NSString+MorseCode.h
//  MorseTorch
//
//  Created by Reed Sweeney on 4/15/14.
//  Copyright (c) 2014 Reed Sweeney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MorseCode)

+(NSMutableArray *)morseSymbolsForString:(NSString *)morseString;
+(NSString *)letterForSymbol:(NSString *)morseLetter;

@end
