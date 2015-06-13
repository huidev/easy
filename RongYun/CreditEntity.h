//
//  CreditEntity.h
//  RongYun
//
//  Created by 乐米科技 on 5/22/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseEntity.h"

@interface CreditEntity : BaseEntity

@property (strong, nonatomic)NSString *recordId;

@property (strong, nonatomic)NSString *m_t_id;
@property (strong, nonatomic)NSString *m_t_name;
@property (strong, nonatomic)NSString *m_integral;
@property (strong, nonatomic)NSString *m_balance;
@property (strong, nonatomic)NSString *m_right;
@property (strong, nonatomic)NSString *u_id;
@property (strong, nonatomic)NSString *s_id;
@property (strong, nonatomic)NSString *m_state;
@property (strong, nonatomic)NSString *m_desc;

@property (strong, nonatomic)NSString *m_date;
@property (strong, nonatomic)NSString *m_id;
@property (strong, nonatomic)NSString *m_ico;
@end
