//
//  StrUtils.m
//  RongYun
//
//  Created by 乐米科技 on 5/8/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "StrUtils.h"

@implementation StrUtils
+ (BOOL)isEmpty:(NSString *)aStr
{
    
    if (aStr == nil || [aStr isEqual:[NSNull null]] || aStr.length == 0 || [aStr isEqualToString:@""]) {
        return YES;
    }
    
    NSString *theStr = [self removeEndSpaceFrom:aStr];
    if (theStr.length == 0 || [theStr isEqualToString:@""]) {
        return YES;
    }
    
    NSString *subStr = [self removeLineFeedFrom:aStr];
    if (subStr.length == 0 || [subStr isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

+(NSString *)removeLineFeedFrom:(NSString *)headerData{
    headerData = [headerData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    headerData = [headerData stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    headerData = [headerData stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return headerData;
}

+(NSString *)removeEndSpaceFrom:(NSString *)strtoremove{
    NSUInteger location = 0;
    unichar charBuffer[[strtoremove length]];
    [strtoremove getCharacters:charBuffer];
    NSInteger i = 0;
    for ( i = [strtoremove length]; i >0; i--){
        if (![[NSCharacterSet whitespaceCharacterSet] characterIsMember:charBuffer[i - 1]]){
            break;
        }
    }
    return  [strtoremove substringWithRange:NSMakeRange(location, i  - location)];
}

+ (NSString *)smallPicStr:(NSString *)aStr
{
    if ([self isEmpty: aStr]) {
        return @"";
    }
    NSArray *array = [aStr componentsSeparatedByString:@"/"];
    NSMutableArray *mutableArray = [array mutableCopy];
    NSString *str = [[NSString alloc] initWithFormat:@"small_%@",[mutableArray lastObject]];
    [mutableArray replaceObjectAtIndex:mutableArray.count-1 withObject:str];
    NSString *resultStr = [mutableArray componentsJoinedByString:@"/"];
    return resultStr;
}


+ (NSString *)timeNumToStr:(NSString *)aStr
{
    if (aStr == nil || [aStr isEqualToString:@""]) {
        return aStr;
    }
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy'-'MM'-'dd"];
    NSDate *date = [format dateFromString:aStr];
    
    NSDateFormatter *newFormat = [[NSDateFormatter alloc] init];
    [newFormat setDateFormat:@"MM'/'dd"];
    NSString *newStr = [newFormat stringFromDate:date];
    
    return newStr;
}

+ (NSString *)commentTime:(NSString *)aStr
{
    NSArray *array_l = [aStr componentsSeparatedByString:@" "];
    if (array_l != nil && array_l.count > 0) {
        //    MLOG(@"time:%@", [array_l objectAtIndex:0]);
        return [array_l objectAtIndex:0];
    }
    return @"";
}

+ (BOOL)checkMobileNumber:(NSString *)aStr
{
    if (aStr == nil) {
        return NO;
    }
    //fly..begin 适配17X
    NSString * mobileFormat = @"^((13[0-9])|(17[0-9])|(15[^(4,\\D)])|(18[0-9]))\\d{8}$";
    //    NSString * mobileFormat = @"^((13[0-9])|170|(15[^(4,\\D)])|(18[0-9]))\\d{8}$";
    //fly..end
    
    
    NSPredicate *regexMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileFormat];
    if ([regexMobile evaluateWithObject:aStr]) {
        return YES;
    }else {
        return NO;
    }
}

+ (BOOL)checkTelephoneNumber:(NSString *)aStr
{
    if (aStr == nil) {
        return NO;
    }
    NSString * mobileFormat = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regexMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileFormat];
    if ([regexMobile evaluateWithObject:aStr]) {
        return YES;
    }else {
        return NO;
    }
}

+ (BOOL)checkHttpAddress:(NSString *)aStr;
{
    if (aStr == nil) {
        return NO;
    }
    NSString * mobileFormat = @"[a-zA-z]+://[^\\s]*";
    
    NSPredicate *regexMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileFormat];
    if ([regexMobile evaluateWithObject:aStr]) {
        return YES;
    }else {
        return NO;
    }

}
+(BOOL)checkCode:(NSString *)astr
{
    NSScanner* scan = [NSScanner scannerWithString:astr];
    int val;
    if([scan scanInt:&val] && [scan isAtEnd] && astr.length == 6) {
        return YES;
    }else return NO;
}

+ (BOOL)checkPwd:(NSString *)aStr
{
    
    if (aStr.length >= 6 && aStr.length <= 16) {
        return YES;
    }else
        return NO;
}

+ (BOOL)isValidateIDCard:(NSString *)IDCard
{
    NSString *IDCardRegex15 = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
    NSString *IDCardRegex18 = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}[\\d|x|X]$";
    NSPredicate *predicate15 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IDCardRegex15];
    NSPredicate *predicate18 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IDCardRegex18];
    return [predicate15 evaluateWithObject:IDCard] || [predicate18 evaluateWithObject:IDCard];
}

/// <summary>
/// 验证身份证号码
/// </summary>
/// <param name="Id">身份证号码</param>
/// <returns>验证成功为YES，否则为NO</returns>
+ (BOOL)CheckIDCard:(NSString*)cardId
{
    NSString* checkId = cardId;
    if(cardId.length == 15){
        checkId = [StrUtils convertCard15To18:cardId];
        return [StrUtils CheckIDCard18:checkId];
        return NO;
    }
    else if(cardId.length == 18){
        return [StrUtils CheckIDCard18:cardId];
    }
    return NO;
}

//验证18位身份证号码
+ (BOOL)CheckIDCard18:(NSString*)cardId
{
    NSArray* address =  @[@"11",@"22",@"35",@"44",@"53",@"12",@"23",@"36",@"45",
                          @"54",@"13",@"31",@"37",@"46",@"61",@"14",@"32",@"41",
                          @"50",@"62",@"15",@"33",@"42",@"51",@"63",@"21",@"34",
                          @"43",@"52",@"64",@"65",@"71",@"81",@"82",@"91"];
    for( int i = 0; i < [address count]; ++i){
        if ([[cardId substringWithRange:NSMakeRange(0, 2)] isEqualToString:address[i]]){
            break;//省份验证正确
        }
        else if (i == [address count] - 1){
            return false;//省份验证错误
        }
    }
    
    NSString* birth = [cardId substringWithRange:NSMakeRange(6, 8)];
    if(![StrUtils CheckDate:[birth substringWithRange:NSMakeRange(0, 4)]
                      month:[birth substringWithRange:NSMakeRange(4, 2)]
                        day:[birth substringWithRange:NSMakeRange(6, 2)]]){
        return NO;//生日验证错误
    }
    if(![StrUtils VarifyCode:cardId]){
        return NO;//最后一位校验错误
    }
    return YES;
}

//实现身份证的15位转18位
+ (NSString*)convertCard15To18:(NSString*)cardId
{
    if(cardId.length != 15){
        return @"";
    }
    int iS = 0;
    
    //加权因子常数
    NSArray* iW = @[@7, @9, @10, @5, @8, @4, @2, @1, @6, @3, @7, @9, @10, @5, @8, @4, @2];
    //校验码常数
    NSString* LastCode = @"10X98765432";
    //新身份证号
    NSMutableString* idNew = [[NSMutableString alloc] init];
    [idNew appendString:[cardId substringWithRange:NSMakeRange(0, 6)]];
    //填在第6位及第7位上填上‘1’，‘9’两个数字
    [idNew appendString:@"19"];
    [idNew appendString:[cardId substringWithRange:NSMakeRange(6, 9)]];
    for(int i = 0; i < idNew.length && i < [iW count]; ++i){
        iS += ([[idNew substringWithRange:NSMakeRange(i, 1)] intValue] * [[iW objectAtIndex:i] intValue]);
    }
    //取模运算，得到模值
    int iY = iS % 11;
    //从LastCode中取得以模为索引号的值，加到身份证的最后一位，即为新身份证号。
    [idNew appendString:[LastCode substringWithRange:NSMakeRange(iY, 1)]];
    return idNew;
}

+ (BOOL)CheckDate:(NSString*)year month:(NSString*)month day:(NSString*)day
{
    int iYear  = [year intValue];
    int iMonth = [month intValue];
    int iDay = [day intValue];
    NSMutableArray* Days = [NSMutableArray arrayWithObjects:@31,@28,@31,@30,@31,@30,@31,@31,@30,@31,@30,@31,nil];
    if(iMonth < 1 || iMonth>12)
        return   NO;
    
    BOOL b_IsLeapYear = NO;
    if(iYear % 4 == 0){
        b_IsLeapYear = YES;
        if((iYear % 100 == 0 && iYear % 400 != 0))
            b_IsLeapYear = NO;
    }
    
    if(b_IsLeapYear){
        [Days replaceObjectAtIndex:1 withObject:@29];
    }
    else{
        [Days replaceObjectAtIndex:1 withObject:@28];
    }
    
    if(iDay < 0 || iDay > [[Days objectAtIndex:iMonth - 1] intValue])
        return NO;
    
    return YES;
}

+ (BOOL)VarifyCode:(NSString*)cardId
{
    int iS = 0;
    //加权因子常数
    NSArray* iW = @[@7, @9, @10, @5, @8, @4, @2, @1, @6, @3, @7, @9, @10, @5, @8, @4, @2];
    //校验码常数
    NSString* LastCode = @"10X98765432";
    
    for(int i = 0;i < 17;i++){
        iS += ([[cardId substringWithRange:NSMakeRange(i, 1)] intValue] * [[iW objectAtIndex:i] intValue]);
    }
    
    //取模运算，得到模值
    int iY = iS % 11;
    if(iY < [LastCode length]){
        NSString* lastChar = [LastCode substringWithRange:NSMakeRange(iY, 1)];
        if([[lastChar lowercaseString] isEqualToString:[[cardId substringFromIndex:cardId.length - 1] lowercaseString]]){
            return YES;
        }
    }
    return NO;
}

+ (BOOL)isChineseCharacter:(NSString*)aStr
{
    for(int i=0;i<[aStr length];i++)
    {
        unichar char_nick = [aStr characterAtIndex:i];
        
        ///Unicode --char 值处于区间[19968, 19968+20902]里的，都是汉字
        if(!(char_nick>=19968 && char_nick<= 19968+20902))
        {
            return NO;
        }
    }
    return YES;
}


+ (NSString*)NilToEmptyString:(NSString*)str
{
    return str ? str : @"";
}

+ (NSString *)priceParse:(NSNumber *)aNumber
{
    NSString *price = nil;
    if([aNumber intValue] != 0){
        CGFloat num = [aNumber floatValue];
        price = [NSString stringWithFormat:@"%.1f",(num / 100.0)];
    }
    return price;
    
}

+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (NSString *)subStringMobilePre:(NSString *)mobilePrefix
{
    if([mobilePrefix length] <= 3){
        return nil;
    }
    
    NSString *mobilePre = [[NSString alloc] init];
    mobilePre = [mobilePrefix substringToIndex:3];
    return mobilePre;
}

+ (NSString *)subStringMobileSub:(NSString *)mobileSubfix
{
    if([mobileSubfix length] <= 8){
        return nil;
    }
    
    NSString *mobileSub = [[NSString alloc] init];
    mobileSub = [mobileSubfix substringFromIndex:8];
    return mobileSub;
}

+ (NSString *)subStringidCardPre:(NSString *)idCardPrefix
{
    if([idCardPrefix length] <= 3){
        return nil;
    }
    
    NSString *idCardPre = [[NSString  alloc] init];
    idCardPre = [idCardPrefix substringToIndex:3];
    return idCardPre;
}

+ (NSString *)subStringidCardSub1:(NSString *)idCardSubfix1
{
    if([idCardSubfix1 length] <= 12){
        return nil;
    }
    
    NSString *idCardSub = [[NSString  alloc] init];
    idCardSub = [idCardSubfix1 substringFromIndex:12];
    return idCardSub;
}

+ (NSString *)subStringidCardSub2:(NSString *)idCardSubfix2
{
    if([idCardSubfix2 length] <= 12){
        return nil;
    }
    
    NSString *idCardSub = [[NSString  alloc] init];
    idCardSub = [idCardSubfix2 substringFromIndex:12];
    return idCardSub;
}

+ (BOOL) containsChinese:(NSString *)str
{
    for(int i = 0; i < [str length]; i++) {
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
            return YES;
    }
    return NO;
}

+ (NSString*)getDateWeekString:(NSString *)date{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate* targetDate = [formatter dateFromString:date];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    unsigned int unitFlags = (NSDayCalendarUnit |
                              NSWeekdayCalendarUnit);
    
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:targetDate];
    return [NSString stringWithFormat:@"%@ %@",date,[self getWeekName:[comps weekday]]];
}

+ (NSString*)getWeekName:(NSInteger)index{
    switch (index) {
        case 1:
            return @"周日";
            break;
        case 2:
            return @"周一";
            break;
        case 3:
            return @"周二";
            break;
        case 4:
            return @"周三";
            break;
        case 5:
            return @"周四";
            break;
        case 6:
            return @"周五";
            break;
        case 7:
            return @"周六";
            break;
        default:
            break;
    }
    return @"";
}
+ (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    
    return html;
}

@end
