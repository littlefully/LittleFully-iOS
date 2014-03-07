//
//  LFYModel.m
//  LittleFully
//
//  Created by Nico Prananta on 3/7/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import "LFYObject.h"

#import <NSValueTransformer+MTLPredefinedTransformerAdditions.h>

#import "NSObject+Additionals.h"

#import "MTLModel+Additionals.h"

#import "LFYQuery.h"

@implementation LFYObject

@dynamic query;

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{NSStringFromSelector(@selector(objectId)): @"id"};
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key {
    NSString *keyType = [[self class] propertyTypeStringForPropertyName:key];
    if ([keyType isEqualToString:@"NSNumber"]) {
        return [[self class] toNumberTransformer];
    } else if ([keyType isEqualToString:@"NSString"]) {
        return [[self class] toStringTransformer];
    } else if ([keyType isEqualToString:@"NSURL"]) {
        return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
    } else if ([keyType isEqualToString:@"NSDate"]) {
        return [[self class] toDateTransformer];
    }
    return nil;
}

- (LFYQuery *)query {
    return [LFYQuery queryWithClass:self.class];
}


@end
