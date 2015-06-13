//
//  CommInfo.m
//  RongYun
//
//  Created by 乐米科技 on 5/11/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "CommInfo.h"
#import "WHGlobal.h"
#import "UserDefaultsUtils.h"
static NSMutableDictionary *keychainDataItem;
@implementation CommInfo

+ (void)setUserInformation:(NSDictionary *)dic;
{
    [UserDefaultsUtils saveValue:dic forKey:USER_INFORMATION];
}

+ (NSDictionary *)getUserInformation
{
    NSDictionary *result = [UserDefaultsUtils valueWithKey:USER_INFORMATION];
    return result;
}
+ (void) setToken:(NSString *)token
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults] ;
    [defaults setObject:token forKey:TOKEN];
    [defaults synchronize];
}
+ (NSString *)getToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults] ;
    return [defaults objectForKey:TOKEN];
}
+ (void)setRememberPassword:(BOOL)flag;
{
    [UserDefaultsUtils saveBoolValue:flag withKey:REMEMBER_PASSWORD];
}

+ (BOOL)getRememberPassword;
{
    return [UserDefaultsUtils boolValueWithKey:REMEMBER_PASSWORD];
}
+ (void)deleteToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults] ;
    [defaults removeObjectForKey:TOKEN];
}


+ (void)logout
{

    [[WHGlobal shareInstance] clearPersonInfo];
    [self deleteToken];
    [self setToken:@""];
    [self setUserId:@""];
    
}

+ (void) setPushToken:(NSData *)deviceToken
{
    NSString* token  = [[[deviceToken description]
                         stringByReplacingOccurrencesOfString: @"<" withString: @""]
                        stringByReplacingOccurrencesOfString: @">" withString: @""];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    if (token == nil) {
        return ;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults] ;
    [defaults setObject:token forKey:PUSHTOKEN];
    [defaults synchronize];
}

+ (NSString *)getPushToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults] ;
    NSString *token_l = [defaults objectForKey:PUSHTOKEN];
//    MLOG(@"device token:%@", token_l);
    if (token_l == nil) {
        return @"";
    }
    return token_l;
}

+ (NSString *)getUserId
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults] ;
    NSString *userId = [defaults objectForKey:USERID];
    if (userId) {
        return userId;
    }
    return @"";
}

+ (void)setUserId:(NSString *)userId
{
    if (!userId) {
        return ;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults] ;
    [defaults setObject:userId forKey:USERID];
    [defaults synchronize];
}

+ (void)setLoginUserName:(NSString *)userName
{
    if (!userName) {
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults] ;
    [defaults setObject:userName forKey:kLoginUserName];
    [defaults synchronize];
}

+ (NSString *)loginUserName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults] ;
    NSString *userName = [defaults objectForKey:kLoginUserName];
    if (userName) {
        return userName;
    }
    return @"";
}
+ (void)setPassword:(NSString *)userName
{
    if (!userName) {
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults] ;
    [defaults setObject:userName forKey:PASSWARD];
    [defaults synchronize];
}
+ (NSString *)getPassword
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults] ;
    NSString *userName = [defaults objectForKey:PASSWARD];
    if (userName) {
        return userName;
    }
    return @"";
}

+ (NSArray *)getSearchHistory
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults] ;
    NSData *data = [defaults objectForKey:SEARCHHISTORY];
    NSArray *history_l = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (history_l == nil) {
        return [[NSArray alloc] init];
    }
    return history_l;
}

+ (void)setSearchHistory:(NSArray *)aHistoryArray
{
    if (aHistoryArray == nil) {
        return ;
    }
    NSMutableArray *array_l = [[NSMutableArray alloc] initWithArray:aHistoryArray];
    if (aHistoryArray.count > 15) {
        NSRange removeRange_l = {15, array_l.count - 15};
        [array_l removeObjectsInRange:removeRange_l];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults] ;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array_l];
    [defaults setObject:data forKey:SEARCHHISTORY];
    [defaults synchronize];
}

+ (void)insertSearchHistory:(NSString *)aHistory
{
    if ([StrUtils isEmpty:aHistory]) {
        return ;
    }
    NSArray *histories = [self getSearchHistory];
    NSMutableArray *mutableHistories = [histories mutableCopy];
    for (int i = 0; i <mutableHistories.count; i++) {
        NSString *str = [mutableHistories objectAtIndex:i];
        if ([str isEqualToString:aHistory]) {
            return ;
        }
    }
    [mutableHistories insertObject:aHistory atIndex:0];
    [self setSearchHistory:mutableHistories];
}
+ (void)clearSearchHistory{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults] ;
    [defaults removeObjectForKey:SEARCHHISTORY];
    [defaults synchronize];
}

+ (NSString*)getLocationCity{
    //LOCATIONCITY
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults] ;
    return [defaults objectForKey:LOCATIONCITY];
    
}
+ (void)setLocationCity:(NSString*)city{
//    MLOG(@"locality->%@",city);
    if ([StrUtils isEmpty:city]) {
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:city forKey:LOCATIONCITY];
    [defaults synchronize];
}

+ (NSString*)getNowMobile
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults] ;
    return [defaults objectForKey:NOWMOBILE];
}

+ (void)setNowMobile:(NSString*)mobile
{
    if ([StrUtils isEmpty:mobile]) {
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:mobile forKey:NOWMOBILE];
    [defaults synchronize];
}

+ (BOOL)isHadShowReviewApp{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults] ;
    return [defaults boolForKey:ISSHOWREVIEWAPP];
}
+ (void)hadShowReviewApp{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:ISSHOWREVIEWAPP];
    [defaults synchronize];
}


+ (void)saveWeiXinCode:(NSString *)code state:(NSString *)state
{
    if([StrUtils isEmpty:code] ||[StrUtils isEmpty:state]) {
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:code forKey:WEIXINCODE];
    [defaults setObject:state forKey:WEIXINSTATE];
    [defaults synchronize];
}

+ (NSString *)getWeinXinCode
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults] ;
    return [defaults objectForKey:WEIXINCODE];
}

+ (NSString *)getWeinXinState
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults] ;
    return [defaults objectForKey:WEIXINSTATE];
}



@end
