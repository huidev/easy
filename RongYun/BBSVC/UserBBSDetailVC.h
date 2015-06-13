//
//  UserBBSDetailVC.h
//  RongYun
//
//  Created by apple on 15/5/21.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "BaseViewController.h"
#import "UserBBSModel.h"
#import "BBSEntity.h"
@interface UserBBSDetailVC : BaseViewController

@property (weak, nonatomic) IBOutlet PullTableView *myTableView;

@property (nonatomic,strong)UserBBSModel *bbsModel;
@property (nonatomic,strong)BBSEntity *bbsEntity;
@property (nonatomic,assign)NSInteger type;//1代表论坛模块的详情   2代表我的论坛的详情


@end
