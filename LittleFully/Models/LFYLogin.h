//
//  LFYLogin.h
//  LittleFully
//
//  Created by Nico Prananta on 3/11/14.
//  Copyright (c) 2014 Little Fully. All rights reserved.
//

#import <Mantle.h>

@interface LFYLogin : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *path;

@property (nonatomic, copy, readonly) NSString *uid;

@property (nonatomic, copy, readonly) NSString *sid;

@end
