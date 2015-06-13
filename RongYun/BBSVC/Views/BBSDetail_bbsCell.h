//
//  BBSDetail_postCell.h
//  RongYun
//
//  Created by apple on 15/5/22.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserBBSModel.h"
#import "BBSEntity.h"

@interface BBSDetail_bbsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *postBtn;
@property (weak, nonatomic) IBOutlet UIButton *replyBtn;

@property (weak, nonatomic) IBOutlet UIButton *peopleBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (nonatomic,strong) UserBBSModel *bbsModel;
@property (nonatomic,strong) BBSEntity *bbEntity;


@end
