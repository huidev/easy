//
//  postDetail.h
//  RongYun
//
//  Created by apple on 15/5/16.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"
#import "PostModel.h"
#import "BaseViewController.h"
@interface PostDetail : BaseViewController

@property (nonatomic,strong) PostModel *postModel;

@property (weak, nonatomic) IBOutlet PullTableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
- (IBAction)reply:(id)sender;

@end
