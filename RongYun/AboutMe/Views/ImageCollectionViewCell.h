//
//  ImageCollectionViewCell.h
//  RongYun
//
//  Created by apple on 15/5/15.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoModel.h"

@interface ImageCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) PhotoModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIImageView *praiseImageV;
@property (weak, nonatomic) IBOutlet UILabel *praiseLab;
@property (weak, nonatomic) IBOutlet UIImageView *commentImageV;
@property (weak, nonatomic) IBOutlet UILabel *commentLab;


@end
