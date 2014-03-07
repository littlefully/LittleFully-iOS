//
//  XCTestCase+Additionals.h
//  LittleFully
//
//  Created by Nico Prananta on 3/7/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XCTestCase (Additionals)

- (id)objectFromJSONFile:(NSString *)jsonFile;

- (NSString *)stringFromDate:(NSDate *)date;

@end
