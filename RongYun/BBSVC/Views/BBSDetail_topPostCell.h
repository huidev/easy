//
//  BBSDetail_topPostCell.h
//  RongYun
//
//  Created by apple on 15/6/2.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBSDetail_topPostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *topImageV;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIButton *topBtn;
@property (weak, nonatomic) IBOutlet UIButton *enableBtn;
- (IBAction)top:(id)sender;
- (IBAction)enable:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *bgView;

- (IBAction)admin:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *adminBtn;
@end
