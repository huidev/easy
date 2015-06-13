//
//  ChatViewController.h
//  RongYun
//
//  Created by 乐米科技 on 5/9/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseViewController.h"
#import <RongIMKit/RongIMKit.h>
@interface ChatViewController : RCConversationListViewController

@property (nonatomic,strong) NSMutableArray *myDataSource;
@property (nonatomic,strong) RCConversationModel *tempModel;

- (void) updateBadgeValueForTabBarItem;
@end
