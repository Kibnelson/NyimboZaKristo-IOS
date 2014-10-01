//
//  Utils.m
//  NyimboZaKristo
//
//  Created by Nelson on 10/1/14.
//  Copyright (c) 2014 Nelson. All rights reserved.
//

#import "Utils.h"

@implementation Utils


// Function to read raw json file in resources
+ (NSData*)readFileData:(NSString *)name type: (NSString *)type
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    if (filePath) {
        NSData *myData = [NSData dataWithContentsOfFile:filePath];
        if (myData) {
            return myData;
        }
    }
    return nil;
}

@end
