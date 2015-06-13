//
//  NewCreatPhotoVC.h
//  RongYun
//
//  Created by apple on 15/5/14.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "BaseViewController.h"


@interface NewCreatPhotoVC : BaseViewController<UITextFieldDelegate>

@property (strong,nonatomic)NSMutableArray *upLoadImageArr;


@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *lab1;

@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
- (IBAction)select:(id)sender;

@end
