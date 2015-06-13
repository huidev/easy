//
//  UserInfoSingleton.h
//  RongYun
//
//  Created by apple on 15/6/10.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoSingleton : NSObject

@property (nonatomic,copy)NSString *u_id;
@property (nonatomic,copy)NSString *u_name;
@property (nonatomic,copy)NSString *u_ico;

+ (UserInfoSingleton *)sharedManager;


@end
