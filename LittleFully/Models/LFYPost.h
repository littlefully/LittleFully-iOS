//
//  LFYPost.h
//  LittleFully
//
//  Created by Nico Prananta on 3/7/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import "LFYObject.h"

#import "LFYUser.h"

@interface LFYPost : LFYObject

@property (nonatomic, copy, readonly) LFYUser *owner;

@property (nonatomic, copy, readonly) NSArray *photos;

@property (nonatomic, copy, readonly) NSString *caption;

@property (nonatomic, copy, readonly) NSArray *tags;

@property (nonatomic, copy, readonly) NSNumber *numberOfLikes;

@property (nonatomic, copy, readonly) NSNumber *numberOfComments;

@property (nonatomic, assign, readonly, getter = isSafe) BOOL safe;

@end
