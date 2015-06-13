//
//  UserEntity.h
//  RongYun
//
//  Created by 乐米科技 on 5/8/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseEntity.h"

@interface UserEntity : BaseEntity

@property (strong, nonatomic)NSString *u_ico;
@property (strong, nonatomic)NSString *u_id;
@property (strong, nonatomic)NSString *u_isdisable;
@property (strong, nonatomic)NSString *u_login_name;
@property (strong, nonatomic)NSString *u_login_pwd;
@property (strong, nonatomic)NSString *u_name;
@property (strong, nonatomic)NSString *u_old_ico;
@property (strong, nonatomic)NSString *u_register_date;
@property (strong, nonatomic)NSString *u_sex;
@property (strong, nonatomic)NSString *u_system_mes;
@property (strong, nonatomic)NSString *u_tel;
@property (strong, nonatomic)NSString *u_tow_dimension_img;

@property (strong, nonatomic)NSString *rstate;
@property (strong, nonatomic)NSString *s_id;
@property (strong, nonatomic)NSString *token;
@property (strong, nonatomic)NSString *u_b_date;
@property (strong, nonatomic)NSString *u_endorse;
@property (strong, nonatomic)NSString *u_forum_mes;

+ (id)sharedUserEntity;
@end
