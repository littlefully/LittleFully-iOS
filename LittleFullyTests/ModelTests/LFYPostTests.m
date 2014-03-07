//
//  LFYPostTests.m
//  LittleFully
//
//  Created by Nico Prananta on 3/7/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "LFYPost.h"

#import "LFYUser.h"

#import "LFYPhoto.h"

#import "LFYTag.h"

#import "XCTestCase+Additionals.h"

#import <Expecta.h>

@interface LFYPostTests : XCTestCase

@end

@implementation LFYPostTests

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
    NSDictionary *postDictionary = [self objectFromJSONFile:@"Post"];
    NSError *error;
    LFYPost *post = [MTLJSONAdapter modelOfClass:[LFYPost class] fromJSONDictionary:postDictionary error:&error];
    
    expect(error).to.beNil;
    expect(post).toNot.beNil;
    expect(post.objectId).to.equal(postDictionary[@"id"]);
    expect(post.caption).to.equal(postDictionary[@"caption"]);
    expect(post.numberOfComments).to.equal(postDictionary[@"numberOfComments"]);
    expect(post.numberOfLikes).to.equal(postDictionary[@"numberOfLikes"]);
    expect(post.isSafe).to.equal(postDictionary[@"safe"]);
    expect(post.owner).toNot.beNil;
    expect(post.owner.objectId).to.equal(postDictionary[@"owner"][@"id"]);
    expect(post.owner.username).to.equal(postDictionary[@"owner"][@"username"]);
    expect(post.owner.avatar.absoluteString).to.equal(postDictionary[@"owner"][@"avatar"]);
    
    expect(post.photos.count).to.equal(1);
    LFYPhoto *photo = post.photos[0];
    expect(photo.objectId).to.equal(postDictionary[@"photos"][0][@"id"]);
    expect(photo.width).to.equal(postDictionary[@"photos"][0][@"width"]);
    expect(photo.height).to.equal(postDictionary[@"photos"][0][@"height"]);
    expect(photo.originalURL.absoluteString).to.equal(postDictionary[@"photos"][0][@"originalURL"]);
    expect(photo.thumbnail200x200URL.absoluteString).to.equal(postDictionary[@"photos"][0][@"thumbnail200x200URL"]);
    
    expect(post.tags.count).to.equal(1);
    LFYTag *tag = post.tags[0];
    expect(tag.name).to.equal(postDictionary[@"tags"][0][@"name"]);
    expect(tag.isSafe).to.equal(postDictionary[@"tags"][0][@"safe"]);
}

@end
