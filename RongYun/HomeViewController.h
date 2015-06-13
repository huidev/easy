//
//  HomeViewController.h
//  RongYun
//
//  Created by 乐米科技 on 5/13/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseViewController.h"
#import "CNPPopupController.h"
#import "ServerListEntity.h"

@interface HomeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,CNPPopupControllerDelegate>

@property (weak, nonatomic)IBOutlet UITableView *m_tableView;
@property (weak, nonatomic)IBOutlet UIView *headView;


#pragma mark -head
@property (weak, nonatomic)IBOutlet UIImageView *logoImageview;

@property (weak, nonatomic)IBOutlet UIButton *mapBT;

@property (weak, nonatomic) IBOutlet UILabel *nameLB;

@property (weak, nonatomic) IBOutlet UILabel *typeLB;

@property (weak, nonatomic) IBOutlet UIButton *attentionBT;

@property (strong, nonatomic)NSString *s_id;
@property (strong, nonatomic)NSString *s_name;
@property (assign, nonatomic)BOOL isAttented;
@property (copy, nonatomic)void (^entireServerBlock)(ServerListEntity *entity);//服务商详情传回serverMain

@property (copy, nonatomic)void (^attendionServerBlock)(ServerListEntity *entity);//关注服务商回调

@property (strong, nonatomic)ServerListEntity *currentServer;
@end
