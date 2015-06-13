//
//  PhotoCell.h
//  RongYun
//
//  Created by apple on 15/5/13.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoAlbumModel.h"

@interface PhotoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UILabel *numCountLab;

@property (nonatomic,strong) PhotoAlbumModel *model;


@end
