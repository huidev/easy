//
//  BaseHandler.h
//  RongYun
//
//  Created by 于君 on 15/5/7.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Handler处理完成后调用的Block
 */
typedef void (^CompleteBlock)();

/**
 *  Handler处理成功时调用的Block
 */
typedef void (^SuccessBlock)(id obj);

/**
 *  Handler处理失败时调用的Block
 */
typedef void (^FailedBlock)(id obj);

@interface BaseHandler : NSObject

/**
 *  获取请求URL
 *
 *  @param path
 *  @return 拼装好的URL
 */
+ (NSString *)requestUrlWithPath:(NSString *)path;
@end
