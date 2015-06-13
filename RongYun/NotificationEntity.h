//
//  NotificationEntity.h
//  RongYun
//
//  Created by 乐米科技 on 5/26/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseEntity.h"

@interface NotificationEntity : BaseEntity

@property (strong, nonatomic)NSString *recordId;
@property (strong, nonatomic)NSString *m_content;
@property (strong, nonatomic)NSString *m_content_des;
@property (strong, nonatomic)NSString *m_date;
@property (strong, nonatomic)NSString *m_from_id;
@property (strong, nonatomic)NSString *m_id;
@property (strong, nonatomic)NSString *m_p_id;
@property (strong, nonatomic)NSString *m_r_id;
@property (strong, nonatomic)NSString *m_state;
@property (strong, nonatomic)NSString *m_title;
@property (strong, nonatomic)NSString *m_to_id;
@property (strong, nonatomic)NSString *m_type;

@end
