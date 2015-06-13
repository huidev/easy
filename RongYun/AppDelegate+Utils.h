//
//  AppDelegate+Utils.h
//  RongYun
//
//  Created by 乐米科技 on 5/12/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (Utils)
- (void)configRongCloud;

- (void)registerForRemoteNotification:(UIApplication*)application;

- (void)registerSDKsToAPP;

- (void)configBaiDuMap;

- (void)takeControlOfTheCookies;

- (void)initPushNumTask;
- (void)requestOpenCitys;

- (void)addNotificationObserver;

#pragma mark - updateAlert

//检查app版本信息
- (void)loopUpIphoneVersionUtil:(BOOL)isSowAlert;
- (void)requiredAPPUpdatenUtil:(NSString*)msg;
- (void)optionalAPPUpdateUtil:(NSString*)msg;
//检测给应用评分
- (void)showReviewAPPAlertViewUtil;
@end
