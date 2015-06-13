//
//  ServerListEntity.h
//  RongYun
//
//  Created by 乐米科技 on 5/9/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseEntity.h"
#import "NSObject+ModelAdditions.h"
@interface ServerListEntity : BaseEntity

@property (nonatomic, strong)NSNumber* recordId;//服务商编号
@property (nonatomic, strong)NSString* s_id;
@property (nonatomic, strong)NSNumber* u_id;//数据编号
@property (nonatomic, strong)NSString* s_ico;//用户电话
@property (nonatomic, strong)NSString* s_name;
@property (nonatomic, strong)NSString* s_desc;//备注信息'
@property (nonatomic, strong)NSString* s_type;//用户编号
@property (nonatomic, strong)NSString* s_info;//服务商编号

@property (nonatomic, strong)NSString* s_address;//服务商编号
@property (nonatomic, strong)NSString* s_tel;
@property (nonatomic, strong)NSString* s_manager;//数据编号
@property (nonatomic, strong)NSString* s_intro;//用户电话
@property (nonatomic, strong)NSString* s_url;
@property (nonatomic, strong)NSString* s_identification_des;//备注信息'
@property (nonatomic, strong)NSString* s_identification_date;//用户编号
@property (nonatomic, strong)NSString* s_identification_end_date;//服务商编号
@property (nonatomic, strong)NSString* s_identification_opinion;//服务商编号

@property (nonatomic, strong)NSString* s_city;
@property (nonatomic, strong)NSString* s_institution_code_img;//数据编号
@property (nonatomic, strong)NSString* s_manager_account;//用户电话
@property (nonatomic, strong)NSString* s_pass;
@property (nonatomic, strong)NSString* s_two_dimension_content;//备注信息'
@property (nonatomic, strong)NSString* s_state;//用户编号
@property (nonatomic, strong)NSString* s_two_dimension_img;//服务商编号
@property (nonatomic, strong)NSString* s_two_dimension_own_img;
@property (nonatomic, strong)NSString* m_ioc;
@property (nonatomic, strong)NSString* m_auto_membership;
@property (nonatomic, strong)NSString* s_distance;

@property (nonatomic, strong)NSString* m_show_point;
@property (nonatomic, strong)NSString* m_show_money;//备注信息'
@property (nonatomic, strong)NSString* s_logo;//用户编号
@property (nonatomic, strong)NSString* s_c_id;//服务商编号
@property (nonatomic, strong)NSString* s_c_path;
@property (nonatomic, strong)NSString* s_m_path;
@property (nonatomic, strong)NSString* s_position_x;
@property (nonatomic, strong)NSString* s_position_y;
@property (nonatomic, strong)NSString* s_valida_state;
@end
