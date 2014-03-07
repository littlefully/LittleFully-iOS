//
//  MTLModel+Additionals.m
//  LittleFully
//
//  Created by Nico Prananta on 3/7/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import "MTLModel+Additionals.h"

#import <MTLValueTransformer.h>

@implementation MTLModel (Additionals)

+ (NSValueTransformer *)toNumberTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(id exifFNumber) {
        if ([exifFNumber isKindOfClass:[NSString class]]) {
            NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterDecimalStyle];
            return [f numberFromString:exifFNumber];
        }
        return exifFNumber;
    } reverseBlock:^id(NSNumber *exifFNumber) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f stringFromNumber:exifFNumber];
    }];
}

+ (NSValueTransformer *)toStringTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(id exifFNumber) {
        if ([exifFNumber isKindOfClass:[NSString class]]) {
            return exifFNumber;
        }
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f stringFromNumber:exifFNumber];
    } reverseBlock:^id(NSString *exifFNumber) {
        return exifFNumber;
    }];
}

+ (NSValueTransformer *)toDateTransformer {
    static dispatch_once_t onceToken;
    static NSDateFormatter *dateFormatter;
    
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    });
    
    return [MTLValueTransformer transformerWithBlock:^id(NSString *string) {
        return [dateFormatter dateFromString:string];
    }];
}

@end
