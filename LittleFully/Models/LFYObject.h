//
//  LFYModel.h
//  LittleFully
//
//  Created by Nico Prananta on 3/7/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import "MTLModel.h"

#import <MTLJSONAdapter.h>

#import <NSValueTransformer+MTLPredefinedTransformerAdditions.h>

@class LFYQuery;

@interface LFYObject : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) LFYQuery *query;

@property (nonatomic, copy, readonly) NSString *objectId;

@property (nonatomic, copy, readonly) NSDate *createdAt;

- (void)save;

- (void)saveWithCompletion:(void(^)(id result, NSError *error))completion;

@end
