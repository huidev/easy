//
//  registViewController.h
//  RongYun
//
//  Created by 乐米科技 on 5/16/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseViewController.h"
#import "LeftViewSpaceField.h"
@interface registViewController : BaseViewController

@property (weak, nonatomic)IBOutlet LeftViewSpaceField *mobileField;

@property (weak, nonatomic)IBOutlet LeftViewSpaceField *authField;

@property (weak, nonatomic)IBOutlet LeftViewSpaceField *passwordField;

@property (weak, nonatomic)IBOutlet LeftViewSpaceField *rePassWField;

@property (weak, nonatomic)IBOutlet UIScrollView *m_scrollView;

@property (weak, nonatomic)IBOutlet UIButton *registBT;

@property (weak, nonatomic)IBOutlet UIButton *protocolBT;

@property (weak, nonatomic)IBOutlet UIButton *authBT;
@end
