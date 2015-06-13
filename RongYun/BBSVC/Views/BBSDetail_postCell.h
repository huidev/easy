//
//  BBSDetail_postCell.h
//  RongYun
//
//  Created by apple on 15/5/22.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostModel.h"

@interface BBSDetail_postCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *accountLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIButton *flagImageV;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLab;
@property (weak, nonatomic) IBOutlet UIButton *setBtn;
- (IBAction)set:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *settopBtn;
- (IBAction)settop:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *forbidBtn;
- (IBAction)forbid:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *setView;

@property (nonatomic,strong) PostModel *postModel;

@end
