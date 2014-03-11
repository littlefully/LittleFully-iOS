//
//  LFYLogin.m
//  LittleFully
//
//  Created by Nico Prananta on 3/11/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import "LFYLogin.h"

@implementation LFYLogin

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{NSStringFromSelector(@selector(sid)): @"id"};
}

@end
