//
//  CardListCell.m
//  RongYun
//
//  Created by 乐米科技 on 5/19/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "CardListCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "WHHttpClient.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "APIConfig.h"
#import "UserEntity.h"
@implementation CardListCell

- (void)awakeFromNib {
    // Initialization code
    self.getBT.layer.cornerRadius = 3;
    [self.getBT.layer setMasksToBounds:YES];
    [self.getBT addTarget:self action:@selector(getCardAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setUserCard:(UserCardEntity *)cardEntity
{
    _userCard = cardEntity;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.cardImageView setImageWithURL:[NSURL URLWithString:cardEntity.c_ico] placeholderImage:IMAGE_HOLD];
    self.titleLB.text = [NSString stringWithFormat:@"本卡券已使用%@张",cardEntity.c_used_count?cardEntity.c_used_count:@""];
    self.dateLB.text = [NSString stringWithFormat:@"领取时间：%@",cardEntity.c_get_date];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[self.userCard.c_info dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    CardListEntity *cardInfo = [[CardListEntity alloc]initWithDict:dic];

    self.getLB.text = [NSString stringWithFormat:@"有效时间：%@",cardInfo.c_validity_date_end];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.getLB attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.dateLB attribute:NSLayoutAttributeLeft multiplier:0 constant:0]];
//    [self.flagImageView removeFromSuperview];
    self.getBT.hidden = YES;
//    self.flagImageView.image = [UIImage imageNamed:@"s_ima_coupon"];
}
- (void)setCardEntity:(CardListEntity *)cardEntity
{
    _cardEntity = cardEntity;
    [self.cardImageView setImageWithURL:[NSURL URLWithString:cardEntity.c_ico] placeholderImage:IMAGE_HOLD];
    self.titleLB.text = [NSString stringWithFormat:@"本卡券可领取%@张",cardEntity.c_e_count?cardEntity.c_e_count:@""];
    self.dateLB.text = [NSString stringWithFormat:@"有效时间：%@",cardEntity.c_validity_date_end];
    self.getLB.text = [NSString stringWithFormat:@"%@",cardEntity.c_condition];
    self.flagImageView.image = [UIImage imageNamed:@"s_ima_coupon"];
    if (![cardEntity.isGet integerValue]) {
        [self.getBT setTitle:@"已领" forState:UIControlStateNormal];
        [self.getBT setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self.getBT setBackgroundColor:RGB(229, 230, 232)];
        self.getBT.enabled = NO;
    }else
    {
        [self.getBT setTitle:@"领取" forState:UIControlStateNormal];
        [self.getBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.getBT setBackgroundColor:RGB(233, 83, 37)];
        self.getBT.enabled = YES;
        
    }
}
- (void)getCardAction:(UIButton *)sender
{
    UserEntity *user = [UserEntity sharedUserEntity];
    NSDictionary *param = @{@"otype":@"add",@"c_count":self.cardEntity.c_count,@"c_id":self.cardEntity.recordId,@"s_id":self.cardEntity.c_servicer_id,@"u_id":user.u_id,@"u_name":user.u_name,@"u_tel":user.u_tel};
    [[WHHttpClient defaultClient]requestWithPath:URL_COUPON method:RTHttpRequestGet parameters:param prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [self.getBT setTitle:@"已领" forState:UIControlStateNormal];
            [self.getBT setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [self.getBT setBackgroundColor:RGB(229, 230, 232)];
            self.getBT.enabled = NO;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
