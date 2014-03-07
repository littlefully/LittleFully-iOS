//
//  LFYPhoto.h
//  LittleFully
//
//  Created by Nico Prananta on 3/7/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import "LFYObject.h"

@interface LFYPhoto : LFYObject

@property (nonatomic, copy, readonly) NSNumber *width;

@property (nonatomic, copy, readonly) NSNumber *height;

@property (nonatomic, copy, readonly) NSURL *originalURL;

@property (nonatomic, copy, readonly) NSURL *thumbnail200x200URL;

@property (nonatomic, copy, readonly) NSDate *timestamp;

@end
