//
//  CustomAppearance.m
//  RongYun
//
//  Created by 乐米科技 on 5/9/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "CustomAppearance.h"

@implementation CustomAppearance

+ (void)customAppearance
{
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], UITextAttributeFont, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], UITextAttributeFont, nil] forState:UIControlStateSelected];
//    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"widget_bar_bg_p"]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage imageNamed:@"widget_bar_bg_n"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: NavigationTitleFont, UITextAttributeFont, [UIColor whiteColor], UITextAttributeTextColor,[UIColor clearColor], UITextAttributeTextShadowColor, nil]];
    [[UINavigationBar appearance]setTitleVerticalPositionAdjustment:0 forBarMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, [UIFont systemFontOfSize:16], UITextAttributeFont, [UIColor clearColor], UITextAttributeTextShadowColor, nil] forState:UIControlStateNormal];
    //    针对6， 及7之后分别设置不同的navigationbar image, 在7下，对barButtonItem不做改变
    UIImage *barImage = nil;
    if (IS_IOS7_OR_LATER)
    {
        barImage = [[UIImage imageNamed:@"nav_background"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"btn_back_arrow"]];
        [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"btn_back_arrow_focus"]];
        [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    }
    else
    {
        barImage = [[UIImage imageNamed:@"navigationBar"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [[UIBarButtonItem appearance] setBackgroundImage:[[UIImage imageNamed:@"translucent"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [[UIBarButtonItem appearance] setBackgroundImage:[[UIImage imageNamed:@"translucent"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    }
    [[UINavigationBar appearance] setBackgroundImage:barImage forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance]setTranslucent:NO];
//    [[UINavigationBar appearance]setBackgroundColor:[UIColor redColor]];
}

@end
