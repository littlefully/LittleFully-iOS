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

#import <FXKeychain.h>

#import "LFYHTTPSessionManager.h"

#import "LFYPhoto.h"

#import "LFYLogin.h"

#import "LFYUser.h"

NSString *progressBlockKey = @"com.littlefully.progressBlockKey";

NSString *littleFullyCookieKey = @"com.littlefully.cookieKey";

@interface LFYClient ()

@property (nonatomic, strong) LFYHTTPSessionManager *manager;

@property (nonatomic, strong) NSMutableDictionary *uploadDictionary;

@property (nonatomic, strong) NSDictionary *cookieProperties;

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

#pragma mark - APIs

- (NSURLSessionDataTask *)loginWithUsername:(NSString *)username password:(NSString *)password completion:(void (^)(id, NSError *))completion {
    __weak typeof (self) selfie = self;
    return [self POST:@"users/login" parameters:@{@"username": username, @"password": password} resultClass:[LFYLogin class] completion:^(id result, NSError *error) {
        __strong typeof (selfie) strongSelfie = selfie;
        if (error) {
            [strongSelfie handleError:error completion:completion];
        } else {
            NSHTTPCookie *cookie = [[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:LITTLEFULLY_API_URL]] firstObject];
            if (cookie) {
                [[FXKeychain defaultKeychain] setObject:cookie.properties forKey:littleFullyCookieKey];
                self.cookieProperties = cookie.properties;
            }
            [strongSelfie fetchMeWithCompletion:completion];
        }
    }];
}

- (NSURLSessionDataTask *)fetchMeWithCompletion:(void (^)(id, NSError *))completion {
    __weak typeof (self) selfie = self;
    return [self GET:@"users/me" parameters:nil resultClass:[LFYUser class] completion:^(LFYUser *user, NSError *err) {
        if (err) {
            [selfie handleError:err completion:completion];
        } else {
            if (user) {
                [user setAsMe];
                completion(user, err);
            } else {
                NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorUserAuthenticationRequired userInfo:@{NSURLErrorFailingURLErrorKey: [NSURL URLWithString:[NSString stringWithFormat:@"%@/users/me", LITTLEFULLY_API_URL]]}];
                completion(nil, error);
            }
        }
    }];
}

- (NSURLSessionDataTask *)logoutWithCompletion:(void (^)())completion {
    __weak typeof (self) selfie = self;
    return [self POST:@"users/logout" parameters:nil resultClass:nil completion:^(id result, NSError *error) {
        selfie.cookieProperties = nil;
        [[FXKeychain defaultKeychain] removeObjectForKey:littleFullyCookieKey];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:nil forURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", LITTLEFULLY_API_URL]] mainDocumentURL:nil];
        if (error) {
            [selfie handleError:error completion:completion];
        } else {
            [LFYUser removeMe];
            [selfie handleResponseObject:result resultClass:nil completion:completion];
        }
    }];
}

#pragma mark - HTTP Methods

- (void)setupCookies {
    if (!self.cookieProperties) {
        self.cookieProperties = [[FXKeychain defaultKeychain] objectForKey:littleFullyCookieKey];
        NSHTTPCookie *cookie ;
        if (self.cookieProperties && [self.cookieProperties isKindOfClass:[NSDictionary class]]) {
            cookie = [NSHTTPCookie cookieWithProperties:self.cookieProperties];[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:@[cookie] forURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", LITTLEFULLY_API_URL]] mainDocumentURL:nil];
        } else {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:nil forURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", LITTLEFULLY_API_URL]] mainDocumentURL:nil];
        }
        
        return;
    }
}

- (NSURLSessionDataTask *)GET:(NSString *)path parameters:(NSDictionary *)parameters resultClass:(Class)resultClass completion:(void (^)(id, NSError *))completion {
    [self setupCookies];
    __weak typeof (self) selfie = self;
    return [self.manager GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [selfie handleResponseObject:responseObject resultClass:resultClass completion:completion];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [selfie handleError:error completion:completion];
    }];
}

- (NSURLSessionDataTask *)POST:(NSString *)path parameters:(NSDictionary *)parameters resultClass:(Class)resultClass completion:(void (^)(id, NSError *))completion {
    [self setupCookies];
    __weak typeof (self) selfie = self;
    
    return [self.manager POST:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [selfie handleResponseObject:responseObject resultClass:resultClass completion:completion];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [selfie handleError:error completion:completion];
    }];
}

- (NSURLSessionDataTask *)PUT:(NSString *)path parameters:(NSDictionary *)parameters resultClass:(Class)resultClass completion:(void (^)(id, NSError *))completion {
    [self setupCookies];
    __weak typeof (self) selfie = self;
    
    return [self.manager PUT:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [selfie handleResponseObject:responseObject resultClass:resultClass completion:completion];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [selfie handleError:error completion:completion];
    }];
}

- (NSURLSessionDataTask *)DELETE:(NSString *)path parameters:(NSDictionary *)parameters resultClass:(Class)resultClass completion:(void (^)(id, NSError *))completion {
    [self setupCookies];
    __weak typeof (self) selfie = self;
    
    return [self.manager DELETE:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [selfie handleResponseObject:responseObject resultClass:resultClass completion:completion];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [selfie handleError:error completion:completion];
    }];
}

- (NSURLSessionUploadTask *)UPLOAD:(UIImage *)image progressBlock:(void(^)(double fractionCompleted))progressBlock completion:(void (^)(id, NSError *))completion {
    [self setupCookies];
    __weak typeof (self) selfie = self;
    
    NSData *data = UIImageJPEGRepresentation(image, 1);
    
    NSString *URLString = [NSString stringWithFormat:@"%@/buckets", LITTLEFULLY_API_URL];
    
    NSProgress *progress;
    
    NSMutableURLRequest *request = [[[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:nil error:nil] mutableCopy];
    [request addValue:@"image/jpeg" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionUploadTask *uploadTask = [self.manager.session uploadTaskWithRequest:request fromData:data];
    
    NSInteger uploadIdentifier = uploadTask.taskIdentifier;
    [self.manager uploadTaskWithTask:uploadTask progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        [selfie.uploadDictionary removeObjectForKey:@(uploadIdentifier)];
        if (completion) {
            if (error) {
                [selfie handleError:error completion:completion];
            } else {
                [selfie handleResponseObject:responseObject resultClass:[LFYPhoto class] completion:completion];
            }
        }
    }];
    
    [self trackProgress:progress progressBlock:progressBlock task:uploadIdentifier];
    [uploadTask resume];
    
    return nil;
}

#pragma mark - Progress handler

- (void)trackProgress:(NSProgress *)progress progressBlock:(void(^)(double fractionCompleted))progressBlock task:(NSInteger)taskIdentifier{
    if (progress && progressBlock) {
        [progress setUserInfoObject:progressBlock forKey:progressBlockKey];
        [progress addObserver:self forKeyPath:NSStringFromSelector(@selector(fractionCompleted)) options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
        if (!self.uploadDictionary) {
            self.uploadDictionary = [NSMutableDictionary dictionary];
        }
        if (![self.uploadDictionary objectForKey:@(taskIdentifier)]) {
            [self.uploadDictionary setObject:progress forKey:@(taskIdentifier)];
        }
    }
}

#pragma mark - Response handler

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

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    double fractionCompleted = [change[NSKeyValueChangeNewKey] doubleValue];
    NSProgress *progress = (NSProgress *)object;
    void (^progressBlock)(double fractionCompleted) = progress.userInfo[progressBlockKey];
    if (progressBlock) {
        progressBlock(fractionCompleted);
    }
    if (fractionCompleted >= 1) {
        [progress removeObserver:self forKeyPath:keyPath];
    }
}

@end
