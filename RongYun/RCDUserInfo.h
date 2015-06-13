//
//  RCDUserInfo.h
//  RCloudMessage
//
//  Created by 杜立召 on 15/3/21.
//  Copyright (c) 2015年 胡利武. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"
@interface RCDUserInfo : BaseEntity
/** 用户ID */
@property(nonatomic, strong) NSString* userId;
/** 用户名*/
@property(nonatomic, strong) NSString* userName;
/** 头像URL*/
@property(nonatomic, strong) NSString* portraitUri;
/** 全拼*/
@property(nonatomic, strong) NSString* quanPin;
/** email*/
@property(nonatomic, strong) NSString* email;
/**  1 好友, 2 请求添加, 3 请求被添加, 4 请求被拒绝, 5 我被对方删除*/
@property(nonatomic, strong) NSString* status;

@property(nonatomic, strong) NSString* a_count;
/** 头像URL*/
@property(nonatomic, strong) NSString* f_city;
/** 全拼*/
@property(nonatomic, strong) NSString* f_ico;
/** email*/
@property(nonatomic, strong) NSString* f_r_content;
/**  1 好友, 2 请求添加, 3 请求被添加, 4 请求被拒绝, 5 我被对方删除*/
@property(nonatomic, strong) NSString* f_r_id;
@property(nonatomic, strong) NSString* f_tel;
/** 头像URL*/
@property(nonatomic, strong) NSString* f_type;
/** 全拼*/
@property(nonatomic, strong) NSString* f_user_id;
/** email*/
@property(nonatomic, strong) NSString* f_user_remark_name;
/**  1 好友, 2 请求添加, 3 请求被添加, 4 请求被拒绝, 5 我被对方删除*/
@property(nonatomic, strong) NSString* user_id;

@property(nonatomic, strong) NSString* user_tel;
@property(nonatomic, strong) NSString* recordId;

@end
