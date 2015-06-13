//
//  MyCardViewController.h
//  RongYun
//
//  Created by 乐米科技 on 5/23/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseViewController.h"

@interface MyCardViewController : BaseViewController

@property (weak, nonatomic)IBOutlet PullTableView *pullView;
@property (strong, nonatomic)NSString *s_id;
@end
