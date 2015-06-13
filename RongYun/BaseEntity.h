//
//  BaseEntity.h
//  RongYun
//
//  Created by 于君 on 15/5/7.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+ModelAdditions.h"
#import "BaseModelObject.h"
#define SUCCESS 0

@interface BaseEntity : BaseModelObject

@property (nonatomic,copy) NSString *_id;//ID
@property (nonatomic     ) int      status;//状态
@property (nonatomic     ) NSString *msg;//状态信息
@property (nonatomic     ) NSString *version;//版本号
@property (nonatomic     ) NSString *updateURL;//升级URL

/**
 *  解析HTTP返回异常JSON
 *
 *  @param json
 *
 *  @return
 */
+ (BaseEntity *)parseResponseErrorJSON:(id)json;

/**
 *  解析成功或失败状态JSON
 *
 *  @param json
 *
 *  @return
 */
+ (BaseEntity *)parseResponseStatusJSON:(id)json;

/**
 *  解析版本号及升级URL JSON
 *
 *  @param json
 *
 *  @return
 */
+ (BaseEntity *)parseResponseUpdateJSON:(id)json;
@end
