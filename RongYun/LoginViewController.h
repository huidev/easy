//
//  LoginViewController.h
//  RongYun
//
//  Created by 乐米科技 on 5/10/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseViewController.h"
#import "LeftViewSpaceField.h"
@interface LoginViewController : BaseViewController

@property (weak, nonatomic)IBOutlet UIScrollView *m_scrollView;
@property (weak, nonatomic) IBOutlet LeftViewSpaceField *accountField;
@property (weak, nonatomic) IBOutlet LeftViewSpaceField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *savePasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *registButton;
@property (weak, nonatomic) IBOutlet UIButton *findPasswordButton;

@property (copy, nonatomic) void(^loginSuccess)();
- (void)leftBarButtonDisplay:(BOOL)flag;
@end
