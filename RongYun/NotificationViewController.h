//
//  NotificationViewController.h
//  RongYun
//
//  Created by 乐米科技 on 5/13/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseViewController.h"
#import "PullTableView.h"
#import "NotificationEntity.h"
#import "NotificationCell.h"
@interface NotificationViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate>

@property (weak, nonatomic)IBOutlet PullTableView *pullView;
@property (strong, nonatomic)NSString *s_id;
@end
