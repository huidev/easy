//
//  ConsumeViewController.h
//  RongYun
//
//  Created by 乐米科技 on 5/20/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//
/**
 * @class 消费记录
 */
#import "BaseViewController.h"
#import "PullTableView.h"
@interface ConsumeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate>

@property (weak, nonatomic)IBOutlet PullTableView *m_tableView;
@property (strong, nonatomic)NSString *s_id;
@end
