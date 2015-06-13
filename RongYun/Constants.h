//
//  Constants.h
//  RongYun
//
//  Created by 于君 on 15/5/7.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#ifndef RongYun_Constants_h
#define RongYun_Constants_h
#import <Foundation/Foundation.h>

//COLOR
#define COLOR_MAIN @"#0096db"

//APP INFO
#define APP_NAME @"AppName"
#define VERSION @"v0.1.0"
#define COPYRIGHT @"Copyright @2014 ZLYCARE All Rights Reserved"

//数据库版本号
#define DB_VERSION @"1"

//FONT SIZE
#define FONT_SIZE 15.0f

/// NSError userInfo key that will contain response data
#define JSONResponseSerializerWithDataKey @"JSONResponseSerializerWithDataKey"
//#define RONGCLOUD_IM_APPKEY @"z3v5yqkbv8v30"
#define RONGCLOUD_IM_APPKEY @"c9kqb3rdk7auj"
#define BMKMAP_KEY @"rKtWzr3ZkV1FlLoMVE0X6uuX"

//Notification key
#define k_NOTI_NETWORK_ERROR @"k_NOTI_NETWORK_ERROR"        //网络异常
#define k_NOTI_VERSION_UPDATE @"k_NOTI_VERSION_UPDATE"      //版本更新通知


//UserDefaults
#define k_UD_IMG_TOKEN @"k_UD_IMG_TOKEN"                    //七牛图片上传token
#define k_UD_IMG_URL @"k_UD_IMG_URL"                        //七牛图片下载url

//信息提示
#define TEXT_NETWORK_ERROR @"网络异常，请检查网络连接"
#define TEXT_SERVER_NOT_RESPOND @"服务器或网络异常,请稍后重试"

#define IMAGE_HOLD [UIImage imageNamed:@"ic_launcher"]

#define IMAGENAME_BACK @"service_jt"
@interface Constants : NSObject


#endif
