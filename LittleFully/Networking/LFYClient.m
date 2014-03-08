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

@interface LFYClient ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

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
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:LITTLEFULLY_API_URL]];
    }
    return self;
}

- (NSURLSessionDataTask *)GET:(NSString *)path parameters:(NSDictionary *)parameters resultClass:(Class)resultClass completion:(void (^)(id, NSError *))completion {
    __weak typeof (self) selfie = self;
    
    return [_manager GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        id obj = responseObject;
        NSError *err;
        if (responseObject && resultClass) {
            obj = [selfie serializedResponseObject:responseObject resultClass:resultClass error:&err];
        }
        if (completion) {
            if (err) {
                completion(nil, err);
            } else {
                completion(obj, nil);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
}

- (void)POST:(NSString *)path parameters:(NSDictionary *)parameters resultClass:(Class)resultClass completion:(void (^)(id, NSError *))completion {
    
}

- (void)PUT:(NSString *)path parameters:(NSDictionary *)parameters resultClass:(Class)resultClass completion:(void (^)(id, NSError *))completion {
    
}

- (void)DELETE:(NSString *)path parameters:(NSDictionary *)parameters resultClass:(Class)resultClass completion:(void (^)(id, NSError *))completion {
    
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
