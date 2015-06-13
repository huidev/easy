//
//  ServerListCell.h
//  RongYun
//
//  Created by 乐米科技 on 5/10/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerListEntity.h"
@interface ServerListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *flagLB;
@property (weak, nonatomic) IBOutlet UIButton *briefLB;
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *typeLB;

@property (weak, nonatomic) IBOutlet UIImageView *distanceImageView;
@property (strong, nonatomic)ServerListEntity *model;
+ (UINib *)serverListCellNib;
@end
