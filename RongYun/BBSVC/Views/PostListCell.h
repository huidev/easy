//
//  PostCell.h
//  RongYun
//
//  Created by apple on 15/5/16.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostModel.h"

@interface PostListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *fromLab;
@property (weak, nonatomic) IBOutlet UIImageView *porImageV;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *replyLab;

@property (strong, nonatomic) PostModel *postModel;


@end
