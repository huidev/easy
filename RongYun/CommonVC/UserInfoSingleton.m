//
//  UserInfoSingleton.m
//  RongYun
//
//  Created by apple on 15/6/10.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "UserInfoSingleton.h"

@implementation UserInfoSingleton

+ (UserInfoSingleton *)sharedManager {
    static UserInfoSingleton *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

@end
