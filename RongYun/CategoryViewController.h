//
//  CategoryViewController.h
//  RongYun
//
//  Created by 乐米科技 on 6/2/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseViewController.h"

@interface CategoryViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic)IBOutlet UITableView *tableView;
@property (copy, nonatomic)void (^selectBlock)(NSDictionary *item);
@end
