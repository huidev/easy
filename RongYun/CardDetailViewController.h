//
//  CardDetailViewController.h
//  RongYun
//
//  Created by 乐米科技 on 5/19/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//消费卡详情

#import "BaseViewController.h"
#import "CardListEntity.h"
#import "UserCardEntity.h"
@interface CardDetailViewController : BaseViewController

@property (weak, nonatomic)IBOutlet UITableView *m_tableView;
@property (strong, nonatomic)CardListEntity *cardEntity;
@property (strong, nonatomic)UserCardEntity *userCard;
@property (assign, nonatomic)BOOL isMine;
@end
