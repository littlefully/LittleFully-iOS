//
//  LFYCommentTests.m
//  LittleFully
//
//  Created by Nico Prananta on 3/7/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "XCTestCase+Additionals.h"

#import <Expecta.h>

#import "LFYPost.h"

#import "LFYComment.h"

#import "LFYUser.h"

@interface LFYCommentTests : XCTestCase

@end

@implementation LFYCommentTests

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
    NSDictionary *commentDictionary = [self objectFromJSONFile:@"Comment"];
    NSError *error;
    LFYComment *comment = [MTLJSONAdapter modelOfClass:[LFYComment class] fromJSONDictionary:commentDictionary error:&error];
    
    expect(error).to.beNil;
    expect(comment).toNot.beNil;
    
    expect(comment.content).to.equal(commentDictionary[@"content"]);
    expect(comment.objectId).to.equal(commentDictionary[@"id"]);
    expect(comment.post.objectId).to.equal(commentDictionary[@"post"][@"id"]);
    expect(comment.owner.objectId).to.equal(commentDictionary[@"owner"][@"id"]);
}

@end
