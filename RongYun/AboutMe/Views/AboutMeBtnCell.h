//
//  AboutMeBtnCell.h
//  RongYun
//
//  Created by apple on 15/5/12.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AboutMeBtnCellDelegate <NSObject>

-(void)pushMyInfo;
-(void)pushMyPhoto;
-(void)pushMyContact;

@end

@interface AboutMeBtnCell : UITableViewCell

@property (weak,nonatomic)id<AboutMeBtnCellDelegate>mydelegate;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *lineView1;
@property (weak, nonatomic) IBOutlet UIView *lineView2;
@property (weak, nonatomic) IBOutlet UIButton *myInfoBtn;
- (IBAction)showInfoVC:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoBtn;
- (IBAction)showPhoto:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
- (IBAction)showPhone:(id)sender;


@end
