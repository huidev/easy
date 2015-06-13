//
//  ReplyPhotoVC.h
//  RongYun
//
//  Created by apple on 15/6/9.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "BaseViewController.h"
#import "PhotoModel.h"

@interface ReplyPhotoVC : BaseViewController

@property (nonatomic,strong)PhotoModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
- (IBAction)praise:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;
@property (weak, nonatomic) IBOutlet UIButton *meBtn;
@property (weak, nonatomic) IBOutlet UILabel *orderLab;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet PullTableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
- (IBAction)reply:(id)sender;

@end
