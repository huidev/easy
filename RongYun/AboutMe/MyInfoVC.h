//
//  MyInfoVC.h
//  RongYun
//
//  Created by apple on 15/5/12.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "BaseViewController.h"

@interface MyInfoVC : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
