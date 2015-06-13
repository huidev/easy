//
//  PhotoSingle.m
//  RongYun
//
//  Created by apple on 15/6/6.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "PhotoSingleton.h"

@implementation PhotoSingleton

+ (PhotoSingleton *)sharedManager {
    static PhotoSingleton *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}



@end
