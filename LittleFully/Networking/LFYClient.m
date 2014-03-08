//
//  LFYClient.m
//  LittleFully
//
//  Created by Nico Prananta on 3/7/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import "LFYClient.h"

#import <AFNetworking.h>

#import <Mantle.h>

#import "LFYHTTPSessionManager.h"

@interface LFYClient ()

@property (nonatomic, strong) LFYHTTPSessionManager *manager;

@end

@implementation LFYClient

+ (instancetype)sharedClient {
    static LFYClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[LFYClient alloc] init];
    });
    
    return _sharedClient;
}

- (id)init
{
    self = [super init];
    if (self) {
        _manager = [[LFYHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:LITTLEFULLY_API_URL]];
    }
    return self;
}

- (NSURLSessionDataTask *)GET:(NSString *)path parameters:(NSDictionary *)parameters resultClass:(Class)resultClass completion:(void (^)(id, NSError *))completion {
    __weak typeof (self) selfie = self;
    
    return [self.manager GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [selfie handleResponseObject:responseObject resultClass:resultClass completion:completion];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [selfie handleError:error completion:completion];
    }];
}

- (NSURLSessionDataTask *)POST:(NSString *)path parameters:(NSDictionary *)parameters resultClass:(Class)resultClass completion:(void (^)(id, NSError *))completion {
    __weak typeof (self) selfie = self;
    
    return [self.manager POST:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [selfie handleResponseObject:responseObject resultClass:resultClass completion:completion];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [selfie handleError:error completion:completion];
    }];
}

- (NSURLSessionDataTask *)PUT:(NSString *)path parameters:(NSDictionary *)parameters resultClass:(Class)resultClass completion:(void (^)(id, NSError *))completion {
    __weak typeof (self) selfie = self;
    
    return [self.manager PUT:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [selfie handleResponseObject:responseObject resultClass:resultClass completion:completion];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [selfie handleError:error completion:completion];
    }];
}

- (void)DELETE:(NSString *)path parameters:(NSDictionary *)parameters resultClass:(Class)resultClass completion:(void (^)(id, NSError *))completion {
    
}

- (void)UPLOAD:(UIImage *)image completion:(void (^)(id, NSError *))completion {
    
}

- (void)handleResponseObject:(id)responseObject resultClass:(Class)resultClass completion:(void(^)(id result, NSError *error))completion {
    id obj = responseObject;
    NSError *err;
    if (responseObject && resultClass) {
        obj = [self serializedResponseObject:responseObject resultClass:resultClass error:&err];
    }
    if (completion) {
        if (err) {
            completion(nil, err);
        } else {
            completion(obj, nil);
        }
    }
}

- (void)handleError:(NSError *)error completion:(void(^)(id result, NSError *error))completion {
    if (completion) {
        completion(nil, error);
    }
}

- (id)serializedResponseObject:(id)responseObject resultClass:(Class)resultClass error:(NSError **)error{
    id obj = nil;
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        obj = [MTLJSONAdapter modelOfClass:resultClass fromJSONDictionary:responseObject error:error];
    } else if ([responseObject isKindOfClass:[NSArray class]]) {
        obj = [NSMutableArray arrayWithCapacity:[responseObject count]];
        for (id object in responseObject) {
            error = nil;
            id serializedObject = [MTLJSONAdapter modelOfClass:resultClass fromJSONDictionary:object error:error];
            if (error || !serializedObject) {
                break;
            }
            [obj addObject:serializedObject];
        }
    }
    return obj;
}

@end
