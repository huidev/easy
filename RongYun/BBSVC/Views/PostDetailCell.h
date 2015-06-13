//
//  PostDetailCell.h
//  RongYun
//
//  Created by apple on 15/5/16.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostReplyModel.h"
#import "PostModel.h"
@interface PostDetailCell : UITableViewCell

@property (nonatomic,strong)PostReplyModel *model;
@property (nonatomic,strong)PostModel *postModel;
@property (weak, nonatomic) IBOutlet UIView *replyView;

@property (weak, nonatomic) IBOutlet UILabel *landLab;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *porImage;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *landlordLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIView *imageBgView;
@property (weak, nonatomic) IBOutlet UILabel *signatureLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UIButton *reportBtn;
@property (weak, nonatomic) IBOutlet UIButton *replyBtn;
- (IBAction)report:(id)sender;
- (IBAction)reply:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *lineView;

+(CGFloat)cellHeight1:(PostModel *)postModel;
+(CGFloat)cellHeight2:(PostReplyModel *)postModel;

@end
