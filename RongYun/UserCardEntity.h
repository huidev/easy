//
//  UserCardEntity.h
//  RongYun
//
//  Created by 乐米科技 on 5/25/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseEntity.h"

@interface UserCardEntity : BaseEntity

@property (strong, nonatomic)NSString *u_id;
@property (strong, nonatomic)NSString *c_id;
@property (strong, nonatomic)NSString *c_count;
@property (strong, nonatomic)NSString *c_used_count;
@property (strong, nonatomic)NSString *c_get_date;
@property (strong, nonatomic)NSString *u_tow_dimension_img;
@property (strong, nonatomic)NSString *c_ico;
@property (strong, nonatomic)NSString *s_id;
@property (strong, nonatomic)NSString *c_info;
@property (strong, nonatomic)NSString *u_name;
@property (strong, nonatomic)NSString *u_tel;
@property (strong, nonatomic)NSString *c_valida_state;

@end
