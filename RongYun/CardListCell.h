//
//  CardListCell.h
//  RongYun
//
//  Created by 乐米科技 on 5/19/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardListEntity.h"
#import "UserCardEntity.h"
@interface CardListCell : UITableViewCell

@property (weak, nonatomic)IBOutlet UIImageView *cardImageView;
@property (weak, nonatomic)IBOutlet UILabel *titleLB;
@property (weak, nonatomic)IBOutlet UILabel *dateLB;
@property (weak, nonatomic)IBOutlet UILabel *getLB;
@property (weak, nonatomic)IBOutlet UIButton *getBT;
@property (weak, nonatomic)IBOutlet UIImageView *flagImageView;

@property (strong, nonatomic)CardListEntity *cardEntity;
@property (strong, nonatomic)UserCardEntity *userCard;
@end
