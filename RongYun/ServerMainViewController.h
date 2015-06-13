//
//  ServerMainViewController.h
//  RongYun
//
//  Created by 乐米科技 on 5/13/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseViewController.h"
#import "SUNSlideSwitchView.h"
#import "HomeViewController.h"
#import "WeiZhanViewController.h"
#import "BBSViewController.h"
#import "NotificationViewController.h"
#import "ServerListEntity.h"
@interface ServerMainViewController : UIViewController<SUNSlideSwitchViewDelegate>


@property (strong, nonatomic) HomeViewController *homeVC;
@property (strong, nonatomic) WeiZhanViewController *weiZhanVC;
@property (strong, nonatomic) BBSViewController *bbsVC;
@property (strong, nonatomic) NotificationViewController *noticeVC;

@property (weak, nonatomic) IBOutlet SUNSlideSwitchView *slideSwitchView;

//@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

//@property (weak, nonatomic) i
@property (copy, nonatomic)void (^cancelAttentionBlock)(NSString *uid);

@property (strong, nonatomic) NSString *s_id;
@property (strong, nonatomic) ServerListEntity *currentServer;
@end
