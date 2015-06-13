//
//  StrUtils.h
//  RongYun
//
//  Created by 乐米科技 on 5/8/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//


@end
#import <Foundation/Foundation.h>

@interface StrUtils : NSObject

+ (BOOL)isEmpty:(NSString *)aStr;

+(NSString *)removeEndSpaceFrom:(NSString *)strtoremove;

+ (NSString *)smallPicStr:(NSString *)aStr;

+ (NSString *)timeNumToStr:(NSString *)aStr;

+ (NSString *)commentTime:(NSString *)aStr;

+ (BOOL)checkMobileNumber:(NSString *)aStr;

+(BOOL)checkCode:(NSString *)astr;

+ (BOOL)checkPwd:(NSString *)aStr;

+ (BOOL)CheckIDCard:(NSString*)cardId;

+ (BOOL)checkTelephoneNumber:(NSString *)aStr;

+ (BOOL)checkHttpAddress:(NSString *)aStr;

+ (NSString*)NilToEmptyString:(NSString*)str;

+ (NSString *)priceParse:(NSNumber *)aNumber;

+ (BOOL)isValidateEmail:(NSString *)email;

+ (NSString *)subStringMobilePre:(NSString *)mobilePrefix;

+ (NSString *)subStringMobileSub:(NSString *)mobileSubfix;

+ (NSString *)subStringidCardPre:(NSString *)idCardPrefix;

+ (NSString *)subStringidCardSub1:(NSString *)idCardSubfix1;

+ (NSString *)subStringidCardSub2:(NSString *)idCardSubfix2;

+ (BOOL) containsChinese:(NSString *)str;
+ (NSString*)getDateWeekString:(NSString *)date;
+ (NSString *)filterHTML:(NSString *)html;

@end
