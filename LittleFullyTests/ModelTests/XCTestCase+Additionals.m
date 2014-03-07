//
//  XCTestCase+Additionals.m
//  LittleFully
//
//  Created by Nico Prananta on 3/7/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import "XCTestCase+Additionals.h"

@implementation XCTestCase (Additionals)

- (id)objectFromJSONFile:(NSString *)jsonFile {
    NSError *error;
    NSString * filePath = [[NSBundle bundleForClass:[self class]] pathForResource:jsonFile ofType:@"json"];
    id object = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:0 error:&error];
    NSAssert(error==nil, @"%@ => %@", jsonFile, error);
    return object;
}

- (NSString *)stringFromDate:(NSDate *)date {
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    });
    
    return [dateFormatter stringFromDate:date];
}

@end
