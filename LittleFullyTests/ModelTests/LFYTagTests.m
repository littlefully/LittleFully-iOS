//
//  LFYTagTests.m
//  LittleFully
//
//  Created by Nico Prananta on 3/7/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "LFYTag.h"

@interface LFYTagTests : XCTestCase

@end

@implementation LFYTagTests

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
    NSDictionary *tagDictionary = [self objectFromJSONFile:@"Tag"];
    NSError *error;
    LFYTag *tag = [MTLJSONAdapter modelOfClass:[LFYTag class] fromJSONDictionary:tagDictionary error:&error];
    
    expect(error).to.beNil;
    expect(tag).toNot.beNil;
    expect(tag.objectId).to.equal(tagDictionary[@"id"]);
    expect(tag.name).to.equal(tagDictionary[@"name" ]);
    expect(tag.isSafe).to.equal(tagDictionary[@"safe"]);
}

@end
