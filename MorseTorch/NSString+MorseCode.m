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
    // Create an array to hold symbols
    NSMutableArray *symbols = [[NSMutableArray alloc] init];
    // convert the string to uppercase
    morseString = [morseString uppercaseString];
    // lookup symbols for string in a for loop
    for (int i=0; i<morseString.length; i++) {
        NSString *letter = [morseString substringWithRange:NSMakeRange(i, 1)];
        [symbols addObject:[NSString symbolForLetter:letter]];
    }
    
    return symbols;
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







