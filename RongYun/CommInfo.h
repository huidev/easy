//
//  CommInfo.h
//  RongYun
//
//  Created by 乐米科技 on 5/11/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>

#define USER_INFORMATION @"userInformation"
#define USERNAME        @"username"
#define PASSWARD        @"passward"
#define REMEMBER_PASSWORD @"remember_password"
#define TOKEN           @"com.lvxian.wypatient.token"
#define LASTUSERNAME    @"lastusername"
#define USERPHONE       @"userphone"
#define SHOWAPPHELP     @"showApphelp"
#define SHOWDETAILHELP  @"showDetailhelp"
#define REFLESHHOME     @"REFLESHHOME"
#define PUSHTOKEN       @"pushtoken"
#define NEEDGUIDE       @"needguide"
#define REFRESHPATIENT  @"refreshpatient"
#define TOTALJOURNAL    @"totalJournal"
#define TOTALEXPERIENCE @"totalexperience"
#define USERID          @"userId"
#define IMAGEURL        @"imagePath"
#define MESSAGECONTENT  @"messageContent"
#define kLoginUserName  @"loginUserName"
#define SEARCHHISTORY   @"searchhistory"
#define LOCATIONCITY    @"locationCity"
#define FOLLOWSESSONID  @"111111"
#define REVERTTIME      @"revertTime"
#define NOWMOBILE       @"nowMobile"
#define ISSHOWREVIEWAPP @"ISSHOWREVIEWAPP" //已经提示评价过app

#define kDeviceToken @"deviceToken"
#define NEWGUIDERGUAHAOTOP @"guiderguahaoTop"
#define NEWGUIDERGUAHAOBOTTOM @"guiderGuahaoBottom"
#define NEWGUIDERCONSULT @"guiderConsult"
#define NEWGUIDERDOCTOR  @"guiderDoctor"
#define NEWGUIDERHOSPITAL @"guiderHospital"
#define NEWGUIDERHOSPITALDEPART @"guiderHospitalDepart"
#define WEIXINCODE @"weiXinCode"
#define WEIXINSTATE @"weiXinState"



@interface CommInfo : NSObject {
    
}
+ (void)setPassword:(NSString *)userName;
+ (NSString *)getPassword;

+ (void) setToken:(NSString *)token;

+ (NSString *)getToken;

+ (void) deleteToken;

+ (void)setRememberPassword:(BOOL)flag;

+ (BOOL)getRememberPassword;
/**
 ** @descript 保存用户登陆信息
 */
+ (void)setUserInformation:(NSDictionary *)dic;

/**
 ** @descript 获取用户登陆信息
 */
+ (NSDictionary *)getUserInformation;

+ (void)logout;

+ (void)setPushToken:(NSData *)deviceToken;

+ (NSString *)getPushToken;


+ (NSString *)getUserId;
+ (void)setUserId:(NSString *)userId;

+ (void)setLoginUserName:(NSString *)userName;
+ (NSString *)loginUserName;

+ (NSArray *)getSearchHistory;
+ (void)setSearchHistory:(NSArray *)aHistoryArray;
+ (void)insertSearchHistory:(NSString *)aHistory;
+ (void)clearSearchHistory;


+ (NSString*)getLocationCity;
+ (void)setLocationCity:(NSString*)city;

+ (NSString*)getNowMobile;
+ (void)setNowMobile:(NSString*)mobile;

+ (BOOL)isHadShowReviewApp;
+ (void)hadShowReviewApp;

+ (void)saveWeiXinCode:(NSString *)code state:(NSString *)state;
+ (NSString *)getWeinXinState;
+ (NSString *)getWeinXinCode;@end
