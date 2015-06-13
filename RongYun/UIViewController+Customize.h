//
//  UIViewController+Customize.h
//  RongYun
//
//  Created by 乐米科技 on 5/9/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Customize)
- (BOOL)isModal;
- (BOOL)isNavRootViewController;
- (void)closeViewAnimated:(BOOL)animated;


- (UIButton*)buttonWithNavBackStyle:(NSString*)strTitle;
- (UIButton*)buttonWithConfirmStyle:(NSString*)strTitle;
- (UIButton*)buttonWithConfirmStyle:(NSString*)strTitle imageName:(NSString *)strImgName;
- (UIButton*)buttonWithIcon:(NSString*)strImgName;
- (UIView *)viewWithConfirmStyle:(NSString *)strTitle iconImgName:(NSString *)strIconImgName;


- (void)addNavBackButtonWithDefaultAction;
/**
 *  自定义的rightBarButtonItem，调用confirmBtnClick:方法
 *
 *  @param strTitle 按钮的名称
 */
- (void)addNavConfirmButtonWithDefaultAction:(NSString*)strTitle;
- (void)addNavConfirmButtonWithIcon:(NSString *)strImgName;

- (void)addNavConfirmButtonWithDefaultAction:(NSString*)strTitle backGroundImgName:(NSString *)strImgName;
- (void)addNavConfirmButtonWithDefaultAction:(NSString*)strTitle iconImageName:(NSString *)strIconImgName;
- (void)addNavConfirmButtonWithDefaultAction:(NSString*)strTitle
                               iconImageName:(NSString *)strIconImgName
                         withBackGroundImage:(NSString*)bgImg;


- (void)removeNavLeftButton;
//- (void)addNavLeftButtonWithDefaultAction:(NSString*)strTitle;
//- (void)addNavLeftButtonWithDefaultAction:(NSString*)strTitle withBackgroundImage:(NSString *)bgImgName;
//- (void)addNavLeftButtonWithDefaultAction:(NSString*)strTitle iconImageName:(NSString *)strIconImgName;

- (void)addNavCustomtitleView:(NSString*)strNick;

- (void)setConfirmButtonTitle:(NSString *)strTitle;
- (void)setConfirmButtonEnabled:(BOOL)nEnabled;

- (void)confirmBtnClick:(id)sender;
- (void)backBtnClick:(id)sender;
- (void)navLeftBtnItemClick:(id)sender;
//wujuan
- (void)addCanCelButtonWithAction:(NSString *)title;
- (void)cancelButtonClick:(UIButton *)button;
//wujuan

//设置tabbar的badgeView的size
//- (void)setTabBarItemBadgeView;

- (void)resignResponder;
- (void)setViewInteraction;

- (void)setLeftBarButtonItemWithText:(NSString *)text imageName:(NSString *)image respond:(void(^)(UIBarButtonItem *leftItem))action;
- (void)setRightBarButtonItemWithText:(NSString *)text imageName:(NSString *)image;

@end
