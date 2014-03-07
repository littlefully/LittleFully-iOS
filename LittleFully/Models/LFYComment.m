//
//  LFYComment.m
//  LittleFully
//
//  Created by Nico Prananta on 3/7/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import "LFYComment.h"

#import "LFYUser.h"

#import "LFYPost.h"

@implementation LFYComment

+ (NSValueTransformer *)ownerJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[LFYUser class]];
}

+ (NSValueTransformer *)postJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[LFYPost class]];
}


@end
