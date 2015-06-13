//
//  CardListEntity.h
//  RongYun
//
//  Created by 乐米科技 on 5/19/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseEntity.h"
@interface CardListEntity : BaseEntity

@property (strong, nonatomic) NSString *recordId;
@property (strong, nonatomic) NSString *isGet;
@property (strong, nonatomic) NSString *c_servicer_id;
@property (strong, nonatomic) NSString *c_ico;
@property (strong, nonatomic) NSString *c_desc;
@property (strong, nonatomic) NSString *c_count;
@property (strong, nonatomic) NSString *c_e_count;
@property (strong, nonatomic) NSString *c_validity_date_begin;
@property (strong, nonatomic) NSString *c_validity_date_end;
@property (strong, nonatomic) NSString *c_condition;
@property (strong, nonatomic) NSString *S_state;
@property (strong, nonatomic) NSString *c_remarks;
@property (strong, nonatomic) NSString *c_remain;

@end
