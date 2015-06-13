//
//  WYPageManager.h
//  RongYun
//
//  Created by 乐米科技 on 5/9/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface WYPageManager : NSObject
// Current view controller showing on the screen
@property (weak, nonatomic) UIViewController *currentViewController;
@property (nonatomic) BOOL needNibFile;
@property (weak, nonatomic) UIViewController *currentLoadedViewController;

+ (instancetype)sharedInstance;

- (void)pushViewController:(NSString *)viewControllerName;
- (void)pushViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param;
//qmx.begin
- (void)pushViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param animated:(BOOL)animated;
//qmx.end

//leon.begin
- (UIViewController*)popViewControllerWithParam:(NSDictionary*)param;
- (NSArray*)popToViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param;
//leon.end

//fly.begin
- (NSArray *)popToRootViewController:(NSDictionary *)param;
- (UIViewController*)getCurrentShowViewController;

//fly.end

- (void)presentViewController:(NSString *)viewControllerName;
- (void)presentViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param;
- (void)presentViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param inNavigationController:(BOOL)isInNavigationController;
- (void)presentViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param inNavigationController:(BOOL)isInNavigationController animated:(BOOL)animated;

@end
