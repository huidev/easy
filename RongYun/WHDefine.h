//
//  WHDefine.h
//  RongYun
//
//  Created by 乐米科技 on 5/8/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#ifndef RongYun_WHDefine_h
#define RongYun_WHDefine_h

//展示图片view字体串的分割符
//static NSString* const WYImageListImgSeparateFlag = @",";

#pragma mark - Define




#define ISiOS7              ([[[UIDevice currentDevice] systemVersion] intValue] >= 7)


#define DEFINEWEAKSELF    __weak __typeof(self) weakSelf = self
#define DEFINESTRONGSELF  __strong __typeof(weakSelf) strongSelf = weakSelf

#define WYAPP           (AppDelegate *)[[UIApplication sharedApplication] delegate]

#define WYVALIDDICT(dic)  ((dic) && ![(dic) isEqual:[NSNull null]] && [(dic) count] > 0)

#define STRING_FORM_OBJ(obj) [NSString stringWithFormat:@"%@",obj]

#define DOCTORAVATARPLACEHOLDER     [UIImage imageNamed:@"default_doctorAvatar"]
#define PATITENTAVATARPLACEHOLDER   [UIImage imageNamed:@"default_patientAvatar"]
#define HOSPITALAVATARPLACEHOLDER   [UIImage imageNamed:@"hosp_pic"]

//#define HOSPITALAVATARPLACEHOLDER   [UIImage imageNamed:@"default_hospitalAvatar"]
// 当前语言
#define CURRENTLANGUAGE         ([[NSLocale preferredLanguages] objectAtIndex:0])
//file path
#define FilePath(name, type) [[NSBundle mainBundle] pathForResource:(name) ofType:(type)]

//Image file
#define ImageFile(name, type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(name) ofType:(type)]]

#define NavigationTitleFont [UIFont systemFontOfSize:20]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RGB(R, G, B)    [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1.0f]

#define RGBA(R,G,B,A)   [UIColor colorWithRed:(R)/255.0f \
green:(G)/255.0f blue:(B)/255.0f alpha:(A)]
#define COLOR_BG_COLOR                  RGB(235.0, 237.0, 240.0)
#define COLOR_SECONDARY                 RGB(210.0, 234.0, 241.0)
#define COLOR_NORMAL_GRAY               RGB(201.0, 201.0, 201.0)
#define COLOR_DARK_GRAY                 RGB(157.0, 157.0, 157.0)
//#define COLOR_MAIN                      RGB(55., 123., 238.)
#define COLOR_BLUE                      RGB(40., 124., 225.)
#define COLOR_REDWINE                       RGB(183., 39., 47.)
#define COLOR_YELLOW                    RGB()

#define COLOR_NAVBAR    RGB(37.0, 43.0, 52.0)
#define IS_IPHONE4S   ([UIScreen mainScreen].bounds.size.height <= 480.0f)

#define SCREENHEIGHT  ([UIScreen mainScreen].bounds.size.height)
#define SCREENWIDTH   ([UIScreen mainScreen].bounds.size.width)

#define IS_IOS7_OR_LATER    (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
#define IS_IOS6_OR_LATER    (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_5_1)

#define WYAPPSHORTVERSION   [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
//背景色
#define BACKGROUND_COLOR [UIColor colorWithRed:242.0/255.0 green:236.0/255.0 blue:231.0/255.0 alpha:1.0]

//-----------------------文件-----------------------
#define DocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]

#define ArrayWithFile(name) [NSArray arrayWithContentsOfFile:name]

#define INT_STRING(I) [NSString stringWithFormat:@"%d",I]
#define INT_NUMBER(I) [NSNumber numberWithInt:I]
#define FLOAT_NUMBER(F) [NSNumber numberWithFloat:F]
#define BOOL_NUMBER(B) [NSNumber numberWithBool:B]

#define FONT_CELL_SMALL [UIFont systemFontOfSize:15]
//由角度获取弧度 有弧度获取角度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#endif
