//
//  NSString+MorseCode.m
//  MorseTorch
//
//  Created by Reed Sweeney on 4/15/14.
//  Copyright (c) 2014 Reed Sweeney. All rights reserved.
//

#import "NSString+MorseCode.h"

@implementation NSString (MorseCode)

+(NSMutableArray *)morseSymbolsForString:(NSString *)morseString
{
    NSMutableArray *symbols = [[NSMutableArray alloc] init];
    morseString = [morseString uppercaseString];
    for (int i=0; i<morseString.length; i++) {
        NSString *letter = [morseString substringWithRange:NSMakeRange(i, 1)];
        [symbols addObject:[NSString symbolForLetter:letter]];
    }
    return symbols;
}

+(NSString *)letterForSymbol:(NSString *)morseLetter
{
    NSDictionary *morseDict = @{@".-":@"A",
                                @"-...":@"B",
                                @"-.-.":@"C",
                                @"-..":@"D",
                                @".":@"E",
                                @"..-.":@"F",
                                @"--.":@"G",
                                @"....":@"H",
                                @"..":@"I",
                                @".---":@"J",
                                @"-.-":@"K",
                                @".-..":@"L",
                                @"--":@"M",
                                @"-.":@"N",
                                @"---":@"O",
                                @".--.":@"P",
                                @"--.-":@"Q",
                                @".-.":@"R",
                                @"...":@"S",
                                @"-":@"T",
                                @"..-":@"U",
                                @"...-":@"V",
                                @".--":@"W",
                                @"-..-":@"X",
                                @"-.--":@"Y",
                                @"--..":@"Z",
                                @" ":@" "
                                };
    
    return [morseDict objectForKey:morseLetter];
}

+(NSString *)symbolForLetter:(NSString *)letter
{
    NSDictionary *morseDict = @{@"A": @".-",
                                @"B": @"-...",
                                @"C":@"-.-.",
                                @"D":@"-..",
                                @"E":@".",
                                @"F":@"..-.",
                                @"G":@"--.",
                                @"H":@"....",
                                @"I":@"..",
                                @"J":@".---",
                                @"K":@"-.-",
                                @"L":@".-..",
                                @"M":@"--",
                                @"N":@"-.",
                                @"O":@"---",
                                @"P":@".--.",
                                @"Q":@"--.-",
                                @"R":@".-.",
                                @"S":@"...",
                                @"T":@"-",
                                @"U":@"..-",
                                @"V":@"...-",
                                @"W":@".--",
                                @"X":@"-..-",
                                @"Y":@"-.--",
                                @"Z":@"--..",
                                @" ":@" "
                                };
    
    return [morseDict objectForKey:letter];
}

@end







