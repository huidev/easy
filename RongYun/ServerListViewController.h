//
//  ServerListViewController.h
//  RongYun
//
//  Created by 乐米科技 on 5/9/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseViewController.h"
#import "ServerListEntity.h"
#import <CoreLocation/CoreLocation.h>
typedef enum {
    SERVER_RECOMMEND=3,//推荐
    SERVER_ATTENTION,//关注的服务商列表
    SERVER_NEARBY,//附近服务商
}ServerType;
@interface ServerListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate,CLLocationManagerDelegate>
{
    BOOL isRefresh;
}
@property (nonatomic, weak)IBOutlet PullTableView *m_tableView;
@property (nonatomic, assign)ServerType type;
@end
