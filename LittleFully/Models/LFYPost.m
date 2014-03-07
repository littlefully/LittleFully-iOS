//
//  LFYPost.m
//  LittleFully
//
//  Created by Nico Prananta on 3/7/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import "LFYPost.h"

#import "LFYUser.h"

#import "LFYPhoto.h"

#import "LFYTag.h"

@implementation LFYPost

+ (NSValueTransformer *)ownerJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[LFYUser class]];
}

+ (NSValueTransformer *)photosJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[LFYPhoto class]];
}

+ (NSValueTransformer *)tagsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[LFYTag class]];
}

@end
