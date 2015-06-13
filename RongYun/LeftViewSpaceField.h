//
//  LeftViewSpaceField.h
//  fastHouse
//
//  Created by Mac on 14-6-20.
//  Copyright (c) 2014年 lemi. All rights reserved.
//

/*
 
 左边有空隙，且leftView 存在
 
 */

@interface LeftViewSpaceField : UITextField

- (void)setBackgroudImageWith:(NSString *)location;
- (void)createLeftImageView:(NSString *)imageName;
- (void)createLeftLabel:(NSString *)text;
- (void)createRightLabel:(NSString *)text;
- (void)createRightImageView:(NSString *)imageName;
@end
