//
//  MyPhotoVC.h
//  RongYun
//
//  Created by apple on 15/5/13.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "LYHSlideSwitchView.h"
#import "ShowPhotoVC.h"
#import "BaseViewController.h"
#import "WHHttpClient.h"

@interface MyPhotoVC : UIViewController<LYHSlideSwitchViewDelegate,ShowPhotoVCDelegate>

@property (strong, nonatomic) WHHttpClient *httpRequest;

@property (weak, nonatomic) IBOutlet LYHSlideSwitchView *slideSwitchView;

@property(nonatomic,strong)ShowPhotoVC *perPhotoVC;
@property(nonatomic,strong)ShowPhotoVC *familyPhotoVC;
@property(nonatomic,strong)ShowPhotoVC *cloudPhotoVC;

@end
