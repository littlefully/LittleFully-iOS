//
//  LFYUser.m
//  LittleFully
//
//  Created by Nico Prananta on 3/7/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import "LFYUser.h"

NSString *littleFullyMe = @"com.littlefully.me";

@implementation LFYUser

+ (LFYUser *)me {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:littleFullyMe];
    if (data) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return nil;
}

+ (void)removeMe {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:littleFullyMe];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setAsMe {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:littleFullyMe];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
