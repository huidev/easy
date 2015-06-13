//
//  ConsumEntity.h
//  RongYun
//
//  Created by 乐米科技 on 5/22/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseEntity.h"

@interface ConsumEntity : BaseEntity

@property (strong, nonatomic)NSString *recordId;
@property (strong, nonatomic)NSString *u_id;
@property (strong, nonatomic)NSString *s_id;
@property (strong, nonatomic)NSString *s_money;

@property (strong, nonatomic)NSString *s_integral;
@property (strong, nonatomic)NSString *s_deduct;
@property (strong, nonatomic)NSString *s_date;
@property (strong, nonatomic)NSString *m_id;
@property (strong, nonatomic)NSString *s_operator;
//@property (strong, nonatomic)NSString *recordId;
@end
