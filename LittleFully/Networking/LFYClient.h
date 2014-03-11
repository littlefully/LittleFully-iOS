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

#pragma mark - APIs

/**
 *  Login to API using username and password. On success, authenticated user can be accessed via [LFYUser me].
 *
 *  @param username   username to authenticate
 *  @param password   password to authenticate
 *  @param completion block that will be called on completion. error will be nil if authentication is successful.
 *
 *  @return Session data task object
 */

- (NSURLSessionDataTask *)loginWithUsername:(NSString *)username
                                   password:(NSString *)password
                                 completion:(void(^)(id result, NSError *error))completion;

- (NSURLSessionDataTask *)logoutWithCompletion:(void(^)())completion;

#pragma mark - HTTP Methods

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
