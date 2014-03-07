//
//  NSObject+Additionals.m
//  LittleFully
//
//  Created by Nico Prananta on 3/7/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import "NSObject+Additionals.h"

#import "NSString+Additionals.h"

#import <objc/runtime.h>

@implementation NSObject (Additionals)

+ (NSString *)propertyTypeStringForPropertyName:(NSString *)propertyName {
    objc_property_t property = class_getProperty([self class], [propertyName UTF8String]);
    NSString *attributesString = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
    return [attributesString stringBetweenString:@"\"" andString:@"\""];
}

@end
