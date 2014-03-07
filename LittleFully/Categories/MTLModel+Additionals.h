//
//  MTLModel+Additionals.h
//  LittleFully
//
//  Created by Nico Prananta on 3/7/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import "MTLModel.h"

@interface MTLModel (Additionals)

+ (NSValueTransformer *)toNumberTransformer;
+ (NSValueTransformer *)toStringTransformer;
+ (NSValueTransformer *)toDateTransformer;

@end
