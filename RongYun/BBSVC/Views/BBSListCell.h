//
//  BBSListCell.h
//  RongYun
//
//  Created by 乐米科技 on 5/10/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBSEntity.h"
@interface BBSListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *themeImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;

@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *typeLB;

@property (strong, nonatomic) BBSEntity *bbsModel;

@end
