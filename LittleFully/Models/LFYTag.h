//
//  LFYTag.h
//  LittleFully
//
//  Created by Nico Prananta on 3/7/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import "LFYObject.h"

@interface LFYTag : LFYObject

@property (nonatomic, copy, readonly) NSString *name;

@property (nonatomic, assign, readonly, getter = isSafe) BOOL safe;

@end
