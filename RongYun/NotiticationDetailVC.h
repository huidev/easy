//
//  NotiticationDetailVC.h
//  RongYun
//
//  Created by 乐米科技 on 5/26/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseViewController.h"
#import "NotificationEntity.h"
@interface NotiticationDetailVC : BaseViewController

@property (weak, nonatomic)IBOutlet UILabel *typeLB;
@property (weak, nonatomic)IBOutlet UILabel *dateLB;
@property (weak, nonatomic)IBOutlet UILabel *contentLB;

@property (strong, nonatomic)NotificationEntity *notificationEntity;
@end
