//
//  APIConfig.h
//  ZLYDoc
//  API信息
//  Created by Ryan on 14-4-14.
//  Copyright (c) 2014年 ZLY. All rights reserved.
//

#import <Foundation/Foundation.h>

/***************STATUS MESSAGE***************/
#define LOAD_MESSAGE @"稍等，马上就好了^_^"
#define ACCOUNT_MESSAGE @"手机号还没填写了"
#define PASSWORD_MESSAGE @"密码还没填写了"
#define MESSAGE_ACCOUNT_ERROR @"手机号格式不正确"
/***************SERVER HOST***************/
#define DEV_FAKE_SERVER @"http://119.254.110.241:8080/" //Beijing SUN-QUAN  测试环境（北京）
#define PRO_FAKE_SERVER @"http://119.254.110.79:8080/" //Beijing Liu-Bei    线上环境（北京）、
#define FAKE_SERVER @"http://webim.demo.rong.io/"//@"http://119.254.110.241:80/" //Login 线下测试

//#define ContentType @"text/plain"13753837811
#define ContentType @"text/html"

//#define SERVER_HOST @"http://43.240.13.97:8080"
#define SERVER_HOST @"http://www.do-easy.cn"

/***************SERVER API***************/
//登录
#define URL_USER_LOGIN        @"/justHomeApi/UserApi"
#define API_VERSION @""
#define URL_SERVER_LIST       @"/justHomeApi/ServiceApi"
#define URL_MESSAGE           @"/justHomeApi/MesApi"
#define URL_COUPON            @"/justHomeApi/CouponApi"

//我的论坛
#define URL_MYBBS_LIST       @"/justHomeApi/ForumApi"
#define URL_MYPOST_LIST       @"/justHomeApi/ThemeApi"
#define URL_POSTOFBBS_LIST       @"/justHomeApi/ThemeApi"
//个人中心
#define URL_USER_LIST       @"/justHomeApi/UserApi"
#define URL_POSTREPLY_LIST       @"/justHomeApi/ReplyApi"




//相册列表
#define URL_PHOTO_LIST       @"/justHomeApi/AlbumApi"
#define URL_GETTOKEN_LIST       @"/justHomeApi/UptokenApi"
#define URL_QiniuToken       @"/justHomeApi/UptokenApi"
@interface APIConfig : NSObject

@end