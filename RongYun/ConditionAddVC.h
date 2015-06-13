//
//  ConditionAddVC.h
//  RongYun
//
//  Created by 乐米科技 on 5/29/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseViewController.h"
#import "UIViewController+Customize.h"
@interface ConditionAddVC : UITableViewController

@property (weak, nonatomic)IBOutlet UITextField *nameField;

@property (weak, nonatomic)IBOutlet UIButton *searchBT;

@property (weak, nonatomic)IBOutlet UILabel *locationLB;

@property (weak, nonatomic)IBOutlet UILabel *categroyLB;

@property (weak, nonatomic)IBOutlet UITableView *m_tableView;
@end
