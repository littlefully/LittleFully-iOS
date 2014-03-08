//
//  LFYClient.h
//  LittleFully
//
//  Created by Nico Prananta on 3/7/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef DEBUG
#define LITTLEFULLY_API_URL @"http://locahost:5000"
#else
#define LITTLEFULLY_API_URL @"http://the.littlefully.com"
#endif

@interface LFYClient : NSObject

+ (instancetype)sharedClient;

- (NSURLSessionDataTask *)GET:(NSString *)path
                   parameters:(NSDictionary *)parameters
                  resultClass:(Class)resultClass
                   completion:(void(^)(id result, NSError *error))completion;

- (void)POST:(NSString *)path
  parameters:(NSDictionary *)parameters
 resultClass:(Class)resultClass
  completion:(void(^)(id result, NSError *error))completion;

- (void)PUT:(NSString *)path
 parameters:(NSDictionary *)parameters
resultClass:(Class)resultClass
 completion:(void(^)(id result, NSError *error))completion;

- (void)DELETE:(NSString *)path
    parameters:(NSDictionary *)parameters
   resultClass:(Class)resultClass
    completion:(void(^)(id result, NSError *error))completion;

@end
