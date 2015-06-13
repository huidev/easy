//
//  WHGlobal.h
//  RongYun
//
//  Created by 乐米科技 on 5/12/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHGlobal : NSObject
@property (nonatomic) BOOL hasShownKeyborad;

+ (BOOL)isLogin;
+ (void)loginOut;

//获取当前登录患者的信息
- (void)getLoginPersonInfo;
- (void)clearPersonInfo;

//获取当前登录用户本联系人的信息
- (void)getSelfContact;
- (void)clearSelfContact;

+ (instancetype)shareInstance;
@end
