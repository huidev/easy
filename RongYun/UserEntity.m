//
//  UserEntity.m
//  RongYun
//
//  Created by 乐米科技 on 5/8/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "UserEntity.h"

@implementation UserEntity

+ (id)sharedUserEntity;
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[self alloc]init];
    });
    return instance;
}
@end
