//
//  LFYClient.h
//  LittleFully
//
//  Created by Nico Prananta on 3/7/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef DEBUG
#define LITTLEFULLY_API_URL @"http://localhost:5000"
#else
#define LITTLEFULLY_API_URL @"http://the.littlefully.com"
#endif

@class AFHTTPSessionManager;
@class LFYHTTPSessionManager;

@interface LFYClient : NSObject

@property (nonatomic, strong, readonly) LFYHTTPSessionManager *manager;

+ (instancetype)sharedClient;

- (NSURLSessionDataTask *)GET:(NSString *)path
                   parameters:(NSDictionary *)parameters
                  resultClass:(Class)resultClass
                   completion:(void(^)(id result, NSError *error))completion;

- (NSURLSessionDataTask *)POST:(NSString *)path
  parameters:(NSDictionary *)parameters
 resultClass:(Class)resultClass
  completion:(void(^)(id result, NSError *error))completion;

- (NSURLSessionDataTask *)PUT:(NSString *)path
 parameters:(NSDictionary *)parameters
resultClass:(Class)resultClass
 completion:(void(^)(id result, NSError *error))completion;

- (NSURLSessionDataTask *)DELETE:(NSString *)path
    parameters:(NSDictionary *)parameters
   resultClass:(Class)resultClass
    completion:(void(^)(id result, NSError *error))completion;

- (NSURLSessionUploadTask *)UPLOAD:(UIImage *)image
                     progressBlock:(void(^)(double fractionCompleted))progressBlock
                        completion:(void(^)(id result, NSError *error))completion;

@end
