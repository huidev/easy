//
//  postModel.h
//  RongYun
//
//  Created by apple on 15/5/16.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostModel : NSObject

@property (nonatomic,copy)NSString *t_title;//题目
@property (nonatomic,copy)NSString *u_ico;//创建时间
@property (nonatomic,copy)NSString *t_content;//主题内容
@property (nonatomic,copy)NSString *t_create_date;//创建时间
@property (nonatomic,copy)NSString *t_reply_num;//回复总量

@property (nonatomic,copy)NSString *u_id;//创建人（楼主）
@property (nonatomic,copy)NSString *u_name;//用户的姓名
@property (nonatomic,copy)NSString *u_endorse;//个人签名
@property (nonatomic,copy)NSString *t_last_reply_date;//t_last_reply_date
@property (nonatomic,copy)NSString *f_name;//论坛名称
@property (nonatomic,copy)NSString *t_f_id;//论坛id
@property (nonatomic,copy)NSString *t_isdisabled;//是否禁用
@property (nonatomic,copy)NSString *t_photo;//主题的图片
@property (nonatomic,copy)NSString *t_istop;//是否置顶
@property (nonatomic,copy)NSString *f_ispersonal;

@end
