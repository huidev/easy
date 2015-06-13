//
//  BBSCell.h
//  RongYun
//
//  Created by apple on 15/5/18.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserBBSModel.h"

@interface BBSCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UILabel *briefLab;
@property (weak, nonatomic) IBOutlet UIButton *userCountBtn;
@property (weak, nonatomic) IBOutlet UIButton *postCountBtn;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) UserBBSModel *bbsModel;


@end
