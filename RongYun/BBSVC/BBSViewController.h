//
//  BBSViewController.h
//  RongYun
//
//  Created by 乐米科技 on 5/9/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseViewController.h"

@interface BBSViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic)IBOutlet PullTableView *m_tableView;
@end
