//
//  UserPostModel.h
//  RongYun
//
//  Created by apple on 15/5/23.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserBBSModel : NSObject

@property (nonatomic,copy) NSString *f_id;
@property (nonatomic,copy) NSString *f_name;
@property (nonatomic,copy) NSString *f_create_date;
@property (nonatomic,copy) NSString *f_ico;
@property (nonatomic,copy) NSString *f_ico_old;
@property (nonatomic,copy) NSString *f_create_user_id;
@property (nonatomic,copy) NSString *f_create_user_ico;
@property (nonatomic,copy) NSString *f_city;
@property (nonatomic,copy) NSString *f_type;
@property (nonatomic,assign) NSInteger f_theme_num;
@property (nonatomic,assign) NSInteger f_reply_num;
@property (nonatomic,assign) NSInteger f_user_count;
@property (nonatomic,copy) NSString *f_f_ispersonal;
@property (nonatomic,copy) NSString *f_isdisabled;
@property (nonatomic,copy) NSString *f_towdimension_img;
@property (nonatomic,copy) NSString *f_des;

@end
