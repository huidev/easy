//
//  NotificationCell.h
//  RongYun
//
//  Created by 乐米科技 on 5/26/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationEntity.h"
@interface NotificationCell : UITableViewCell
@property (weak, nonatomic)IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic)IBOutlet UILabel *titleLB;
@property (weak, nonatomic)IBOutlet UILabel *contentLB;
@property (weak, nonatomic)IBOutlet UILabel *dateLB;

@property (strong, nonatomic)NotificationEntity *entity;
@end
