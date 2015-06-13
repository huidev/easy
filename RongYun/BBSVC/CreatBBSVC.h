//
//  CreatBBSVC.h
//  RongYun
//
//  Created by apple on 15/6/4.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "BaseViewController.h"

@interface CreatBBSVC : BaseViewController<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *titleTV;
@property (weak, nonatomic) IBOutlet UITextView *conTextView;

@end
