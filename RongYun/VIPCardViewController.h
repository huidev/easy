//
//  VIPCardViewController.h
//  RongYun
//
//  Created by 乐米科技 on 5/20/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//会员卡信息

#import "BaseViewController.h"

@interface VIPCardViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic)IBOutlet UIView *levelView;
@property (weak, nonatomic)IBOutlet UILabel *levelLB;

@property (weak, nonatomic)IBOutlet UIView *creditView;
@property (weak, nonatomic)IBOutlet UILabel *creditLB;

@property (weak, nonatomic)IBOutlet UIView *balanceView;
@property (weak, nonatomic)IBOutlet UILabel *balanceLB;

@property (weak, nonatomic)IBOutlet UIImageView *cardImageView;

@property (weak, nonatomic)IBOutlet UITableView *m_tableView;
@property (strong, nonatomic)NSString *s_id;
@end
