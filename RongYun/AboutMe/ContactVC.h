//
//  ContactVC.h
//  RongYun
//
//  Created by apple on 15/5/15.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYHSlideSwitchView.h"
#import "showContactVC.h"

@interface ContactVC : UIViewController<showContactVCDelegate,LYHSlideSwitchViewDelegate>

@property (weak, nonatomic) IBOutlet LYHSlideSwitchView *slideSwitchView;
@property (nonatomic,strong)showContactVC *friendVC;
@property (nonatomic,strong)showContactVC *familyVC;
@property (nonatomic,strong)showContactVC *peopleVC;


@end
