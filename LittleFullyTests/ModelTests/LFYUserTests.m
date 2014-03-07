//
//  LFYUserTests.m
//  LittleFully
//
//  Created by Nico Prananta on 3/7/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "XCTestCase+Additionals.h"

#import <Expecta.h>

#import "LFYUser.h"

@interface LFYUserTests : XCTestCase

@end

@implementation LFYUserTests

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

- (void)testSerialization
{
    NSDictionary *userDictionary = [self objectFromJSONFile:@"User"];
    NSError *error;
    LFYUser *user = [MTLJSONAdapter modelOfClass:[LFYUser class] fromJSONDictionary:userDictionary error:&error];
    
    expect(error).to.beNil;
    expect(user).toNot.beNil;
    expect(user.objectId).to.equal(userDictionary[@"id"]);
    expect(user.username).to.equal(userDictionary[@"username"]);
    expect(user.avatar.absoluteString).to.equal(userDictionary[@"avatar"]);
    expect(user.numberOfPosts).to.equal(userDictionary[@"numberOfPosts"]);
}

@end
