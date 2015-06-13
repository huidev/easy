//
//  ContactCell.h
//  RongYun
//
//  Created by apple on 15/5/15.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *chatBtn;
- (IBAction)phone:(id)sender;
- (IBAction)chat:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *name;
@end
