//
//  cardViewController.h
//  RongYun
//
//  Created by 乐米科技 on 5/17/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//消费券列表


#import "BaseViewController.h"
#import "PullTableView.h"
#import "CardListEntity.h"
@interface cardViewController : BaseViewController


@property (weak, nonatomic)IBOutlet PullTableView *pullView;
@property (strong, nonatomic)NSString *s_id;
@end
