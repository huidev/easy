//
//  MyPostVC.h
//  RongYun
//
//  Created by apple on 15/5/16.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BBSEntity.h"

@interface MyPostVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic,strong)BBSEntity *bbsModel;
@property (strong, nonatomic) WHHttpClient *httpRequest;

@end
