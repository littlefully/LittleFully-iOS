//
//  LFYComment.h
//  LittleFully
//
//  Created by Nico Prananta on 3/7/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import "LFYObject.h"

@class LFYUser;
@class LFYPost;

@interface LFYComment : LFYObject

@property (nonatomic, copy, readonly) NSString *content;

@property (nonatomic, copy, readonly) LFYPost *post;

@property (nonatomic, copy, readonly) LFYUser *owner;

@end
