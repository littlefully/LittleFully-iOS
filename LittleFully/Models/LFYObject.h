//
//  LFYModel.h
//  LittleFully
//
//  Created by Nico Prananta on 3/7/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import "MTLModel.h"

#import <MTLJSONAdapter.h>

@interface LFYObject : MTLModel <MTLJSONSerializing>

- (NSString *)itemId;

- (void)save;

- (void)saveWithCompletion:(void(^)(id result, NSError *error))completion;

@end
