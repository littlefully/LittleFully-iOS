//
//  LFYQuery.h
//  LittleFully
//
//  Created by Nico Prananta on 3/7/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFYQuery : NSObject

+ (LFYQuery *)queryWithClass:(Class)aClass;

- (void)whereKey:(NSString *)key equalTo:(NSString *)equal;

- (void)getObjectInBackgroundWithId:(NSString *)identifier completion:(void(^)(id result, NSError *error))completion;

- (void)findObjectsWithCompletion:(void(^)(id result, NSError *error))completion;

@end
