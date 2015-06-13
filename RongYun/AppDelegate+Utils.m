//
//  AppDelegate+Utils.m
//  RongYun
//
//  Created by 乐米科技 on 5/12/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "AppDelegate+Utils.h"
#import "CommInfo.h"
#import <RongIMKit/RongIMKit.h>
#import <BaiduMapAPI/BMapKit.h>
@implementation AppDelegate (Utils)
- (void)configBaiDuMap
{
    
}

- (void)configRongCloud
{
    NSString *_deviceTokenCache = [[NSUserDefaults standardUserDefaults]objectForKey:kDeviceToken];
    [[RCIM sharedKit] initWithAppKey:RONGCLOUD_IM_APPKEY deviceToken:_deviceTokenCache];
    //设置会话列表头像和会话界面头像
    [RCIM sharedKit].globalConversationPortraitSize = CGSizeMake(56, 56);
    [RCIM sharedKit].globalMessagePortraitSize = CGSizeMake(40, 40);
}

- (void)registerForRemoteNotification:(UIApplication*)application{
#ifdef __IPHONE_8_0
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //Right, that is the point
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge
                                                                                             |UIRemoteNotificationTypeSound
                                                                                             |UIRemoteNotificationTypeAlert) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else
#endif
    {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeAlert |
        UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
}

- (void)registerSDKsToAPP{
    //微信注册
//    [WXApi registerApp:WXREGISTERID];
//    [WeiboSDK registerApp:WEIBOREGISTERID];
//#if DEBUG
//    [WeiboSDK enableDebugMode:YES];
//#endif
//    //百度统计
//    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
//    statTracker.enableExceptionLog = YES; // 是否允许截获并发送崩溃信息，请设置YES或者NO
//    statTracker.logStrategy = BaiduMobStatLogStrategyAppLaunch;//根据开发者设定的时间间隔接口发送 也可以使用启动时发送策略
//    statTracker.logSendWifiOnly = YES; //是否仅在WIfi情况下发送日志数据
//    [statTracker startWithAppId:BaiduStatAppKey];//设置您在mtj网站上添加的app的appkey
}

#pragma mark - NetWork

- (void)requestOpenCitys{
//    if (![WYCity hadSaveOpenCitys]) {//判断是否有已开通城市的缓存
//        WYTask *task = [[WYTask alloc] initWithURL:URL_GET_OPENCITYS];
//        task.needAutomaticLoadingView = NO;
//        task.needAutomaticErrorMessage = NO;
//        [task startWithParams:nil success:^(id responseObject) {
//            WYBaseItemsModel *itemsModel = [[WYBaseItemsModel alloc] initWithDict:responseObject withItemClass:[WYCity class] withItemsKey:ITEM_KEY_AREAS];
//            [WYCity saveOpenCitys:itemsModel.items];
//        }];
//    }
}

- (void)initPushNumTask
{
#if (TARGET_IPHONE_SIMULATOR)
    {
        
    }
#endif
#if !(TARGET_IPHONE_SIMULATOR)
    if (![[WYGlobal shareInstance] isLogin]) {
        return;
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    WYTask *task = [[WYTask alloc] initWithURL:URL_INITPUSHNUM];
    task.needAutomaticLoadingView = NO;
    task.needAutomaticErrorMessage = NO;
    [task startWithParams:nil success:^(id responseObject) {
        if (![StrUtils isEmpty:[CommInfo getUserId]]) {
            [[WYXMPPAdapter shareInstance] connectXMPPServer];
        }
    }];
#endif
}



- (void)addNotificationObserver{
    [[NSNotificationCenter defaultCenter] addObserverForName:@"kWYNoticePermissionLimited" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [CommInfo logout];
        NSString* msg = @"你的微医帐号已经在其他设备登录，请注意帐号安全。如果这不是你的操作，你的密码可能已泄露，请前往挂号网(guahao.com)修改密码。";
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"连接断开" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }];
}

#pragma mark - alert

- (void)loopUpIphoneVersionUtil:(BOOL)showNewest{
//    WYTask* task = [[WYTask alloc] initWithURL:URL_IPHONEVERSION];
//    task.needAutomaticLoadingView = showNewest;
//    task.needAutomaticErrorMessage = showNewest;
//    [task startWithParams:nil success:^(id responseObject) {
//        WYIphoneVersion* version = [WYIphoneVersion modelObjectWithDict:responseObject];
//        NSString* currentVersion = WYAPPSHORTVERSION;
//        
//        BOOL optionalUpdate = [version.versionName compare:currentVersion] == NSOrderedDescending;
//        if (optionalUpdate) {
//            if ([version.lowestVersion isKindOfClass:[NSNumber class]]) {
//                version.lowestVersion = [NSString stringWithFormat:@"%@",version.lowestVersion];
//            }
//            
//            BOOL requiredUpdate = [version.lowestVersion compare:currentVersion] == NSOrderedDescending;
//            if (requiredUpdate) {
//                [self requiredAPPUpdatenUtil:version.desc];
//            }else{
//                [self optionalAPPUpdateUtil:version.desc];
//            }
//        }else if(showNewest){
//            [WCAlertView showAlertWithTitle:nil message: @"已经是最新版本！" customizationBlock:nil completionBlock:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        }
//    }];
}



- (void)requiredAPPUpdatenUtil:(NSString*)msg{
    
//    [WCAlertView showAlertWithTitle:@"新版本升级" message:msg customizationBlock:nil completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:WYAPP_TRACK_URL]];
//    } cancelButtonTitle:@"立即升级" otherButtonTitles: nil];
}

- (void)optionalAPPUpdateUtil:(NSString*)msg{
//    [WCAlertView showAlertWithTitle:@"新版本升级" message:msg customizationBlock:nil completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
//        if (buttonIndex != alertView.cancelButtonIndex) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:WYAPP_TRACK_URL]];
//        }
//    } cancelButtonTitle:@"取消" otherButtonTitles:@"立即升级", nil];
}

- (void)showReviewAPPAlertViewUtil{
    if (![CommInfo isHadShowReviewApp] ) {
        [CommInfo hadShowReviewApp];
//        [WCAlertView showAlertWithTitle:nil message:@"为挂号网评个分" customizationBlock:nil completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
//            if (buttonIndex == 0) {
//                NSString *reviewURL = nil;
//                if (ISiOS7) {
//                    reviewURL = [[NSString alloc] initWithFormat:kAppStoreReviewsIOS7URL,APP_ID];
//                }else{
//                    reviewURL = [[NSString alloc] initWithFormat:kAppStoreReviewsURL,APP_ID];
//                }
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:reviewURL]];
//            }else  if (buttonIndex == 1) {
//                [[WYPageManager sharedInstance] pushViewController:@"WYFeedBackViewController"];
//            }
//        } cancelButtonTitle:@"残忍拒绝" otherButtonTitles:@"我要评价",@"我要吐槽", nil];
    }
}

#pragma mark -

- (void)takeControlOfTheCookies
{
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
}


@end
