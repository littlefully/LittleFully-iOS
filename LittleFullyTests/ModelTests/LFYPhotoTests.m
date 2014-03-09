//
//  LFYPhotoTests.m
//  LittleFully
//
//  Created by Nico Prananta on 3/7/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "LFYPhoto.h"

@interface LFYPhotoTests : XCTestCase

@end

@implementation LFYPhotoTests

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
    NSDictionary *photoDictionary = [self objectFromJSONFile:@"Photo"];
    NSError *error;
    LFYPhoto *photo = [MTLJSONAdapter modelOfClass:[LFYPhoto class] fromJSONDictionary:photoDictionary error:&error];
    
    expect(error).to.beNil;
    expect(photo).toNot.beNil;
    expect(photo.width).to.equal(photoDictionary[@"width"]);
    expect(photo.height).to.equal(photoDictionary[@"height"]);
    expect(photo.objectId).to.equal(photoDictionary[@"id"]);
    expect(photo.originalURL.absoluteString).to.equal(photoDictionary[@"originalURL"]);
    expect(photo.thumbnail200x200URL.absoluteString).to.equal(photoDictionary[@"thumbnail200x200URL"]);
    expect([photo.createdAt timeIntervalSince1970]*1000).to.equal(photoDictionary[@"createdAt"]);
    expect([photo.timestamp timeIntervalSince1970]*1000).to.equal(photoDictionary[@"timestamp"]);
    
}

@end
