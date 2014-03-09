//
//  LFYClientTests.m
//  LittleFully
//
//  Created by Nico Prananta on 3/8/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "LFYClient.h"

#import "LFYHTTPSessionManager.h"

#import "LFYPost.h"

#import "LFYUser.h"

#import "LFYPhoto.h"

#import "LFYTag.h"

#import <AFHTTPSessionManager.h>

#import <FBKVOController.h>

@interface LFYClient (UnitTests)

- (id)serializedResponseObject:(id)responseObject resultClass:(Class)resultClass error:(NSError **)error;

- (void)trackProgress:(NSProgress *)progress progressBlock:(void(^)(double fractionCompleted))progressBlock task:(NSInteger)taskIdentifier;

@end

@interface UploadObject : NSObject

@property (nonatomic, assign) double fraction;

- (void)startMockUploadWithClient:(LFYClient *)client progress:(NSProgress *)progress;

@end

@implementation UploadObject

- (void)startMockUploadWithClient:(LFYClient *)client progress:(NSProgress *)progress {
    __weak typeof (self) selfie = self;
    [client trackProgress:progress progressBlock:^(double fractionCompleted) {
        if (selfie) {
            selfie.fraction = fractionCompleted;
            NSLog(@"updating fraction done");
        } else {
            NSLog(@"no selfie");
        }
    } task:1000];
}

- (void)dealloc {
    NSLog(@"dealloc");
}

@end

@interface LFYClientTests : XCTestCase

@end

@implementation LFYClientTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testHTTPSessionManager {
    LFYClient *client = [[LFYClient alloc] init];
    expect(client).toNot.beNil;
    expect(client.manager).toNot.beNil;
    expect([client.manager isKindOfClass:[LFYHTTPSessionManager class]]).to.equal(YES);
}

- (void)testArrayResponseObjectSerialization
{
    NSArray *array = [self objectFromJSONFile:@"ResponseArray"];
    LFYClient *client = [[LFYClient alloc] init];
    expect(client).toNot.beNil;
    NSError *error;
    id serializedObject = [client serializedResponseObject:array resultClass:[LFYPost class] error:&error];
    expect(error).to.beNil;
    expect(serializedObject).toNot.beNil;
    expect([serializedObject count]).to.equal(array.count);
    
    LFYPost *post = serializedObject[0];
    expect(post).toNot.beNil;
    expect(post.objectId).to.equal(array[0][@"id"]);
    
    post = [serializedObject lastObject];
    expect(post.objectId).to.equal([array lastObject][@"id"]);
}

- (void)testDictionaryResponseObjectSerialization {
    NSDictionary *dictionary = [self objectFromJSONFile:@"Post"];
    LFYClient *client = [[LFYClient alloc] init];
    expect(client).toNot.beNil;
    NSError *error;
    id serializedObject = [client serializedResponseObject:dictionary resultClass:[LFYPost class] error:&error];
    expect(error).to.beNil;
    expect(serializedObject).toNot.beNil;
    expect([serializedObject isKindOfClass:[LFYPost class]]).to.equal(YES);
    expect([serializedObject objectId]).to.equal(dictionary[@"id"]);
}

- (void)testUploadProgress {
    LFYClient *client = [[LFYClient alloc] init];
    int64_t total = 100;
    NSProgress *progress = [NSProgress progressWithTotalUnitCount:total];
    
    __block double fraction = 0;
    
    [client trackProgress:progress progressBlock:^(double fractionCompleted) {
        fraction = fractionCompleted;
    } task:1000];
    
    int64_t completed = 10;
    [progress setCompletedUnitCount:completed];
    expect(fraction).to.equal((double)completed/total);
    
    completed = 20;
    [progress setCompletedUnitCount:completed];
    expect(fraction).to.equal((double)completed/total);
    
    completed = total;
    [progress setCompletedUnitCount:completed];
    expect(fraction).to.equal((double)completed/total);
}

- (void)testUploadObjectProgress {
    int64_t total = 100;
    NSProgress *progress = [NSProgress progressWithTotalUnitCount:total];
    LFYClient *client = [[LFYClient alloc] init];
    
    UploadObject *upload = [[UploadObject alloc] init];
    [upload startMockUploadWithClient:client progress:progress];
    
    int64_t completed = 10;
    [progress setCompletedUnitCount:completed];
    expect(upload.fraction).to.equal((double)completed/total);
    
    completed = total;
    [progress setCompletedUnitCount:completed];
    expect(upload.fraction).to.equal((double)completed/total);
    
    upload = nil;
}

- (void)testRemoveUploadObjectOnProgress {
    int64_t total = 100;
    NSProgress *progress = [NSProgress progressWithTotalUnitCount:total];
    LFYClient *client = [[LFYClient alloc] init];
    
    UploadObject *upload = [[UploadObject alloc] init];
    [upload startMockUploadWithClient:client progress:progress];
    
    int64_t completed = 10;
    [progress setCompletedUnitCount:completed];
    XCTAssert(upload.fraction==(double)completed/total, @"upload fraction not equal");
    
    NSLog(@"nilling upload");
    upload = nil;
    
    completed = total;
    NSLog(@"here");
    [progress setCompletedUnitCount:completed];
    XCTAssert(upload==nil, @"upload should be nil");
}

@end
