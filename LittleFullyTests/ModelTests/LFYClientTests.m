//
//  LFYClientTests.m
//  LittleFully
//
//  Created by Nico Prananta on 3/8/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "LFYClient.h"

#import "LFYPost.h"

#import "LFYUser.h"

#import "LFYPhoto.h"

#import "LFYTag.h"

@interface LFYClient (UnitTests)

- (id)serializedResponseObject:(id)responseObject resultClass:(Class)resultClass error:(NSError **)error;

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

- (void)testResponseObjectSerialization
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

@end
