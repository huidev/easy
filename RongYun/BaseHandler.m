//
//  BaseHandler.m
//  RongYun
//
//  Created by 于君 on 15/5/7.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "BaseHandler.h"

#import "APIConfig.h"

@implementation BaseHandler

+ (NSString *)requestUrlWithPath:(NSString *)path
{
    return [[@"http://" stringByAppendingString:[SERVER_HOST stringByAppendingString:API_VERSION]] stringByAppendingString:path];
}



@end
