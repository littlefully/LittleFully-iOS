//
//  LFYHTTPSessionManager.h
//  LittleFully
//
//  Created by Nico Prananta on 3/8/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import "AFHTTPSessionManager.h"

extern NSString *const LFYResponseObjectErrorKey;

/**
 *  We subclass AFHTTPSessionManager and override HTTP methods because AFNetworking doesn't pass along responseObject when connection fails. However server sends a dictionary contains message that explains the error. So we need to include that message in the error object.
 */

@interface LFYHTTPSessionManager : AFHTTPSessionManager

@end
