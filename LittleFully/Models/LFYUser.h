//
//  LFYUser.h
//  LittleFully
//
//  Created by Nico Prananta on 3/7/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import "LFYObject.h"

@interface LFYUser : LFYObject

@property (nonatomic, copy, readonly) NSString *username;

@property (nonatomic, copy, readonly) NSURL *avatar;

@end
