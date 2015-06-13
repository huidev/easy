//
//  MyBBSVC.h
//  RongYun
//
//  Created by apple on 15/5/18.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"
#import "BaseViewController.h"

@interface UserBBSListVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) WHHttpClient *httpRequest;

@property (weak, nonatomic) IBOutlet PullTableView *myTableView;

@end
