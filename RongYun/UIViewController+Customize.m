//
//  UIViewController+Customize.m
//  RongYun
//
//  Created by 乐米科技 on 5/9/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "UIViewController+Customize.h"

#define kNavBtnHeight               30
#define kNavBtnIconImgWidth         16
#define kNavBtnIconImgHeight        16
#define kNavBtnIconImgYMagin        6
#define kNavBtnIconImgXMagin        8
#define kNavBtnIconLabXMagin        3
#define kNavBtnIconLabRightMagin    11

#define kNavBtnTag                  100


@implementation UIViewController (Customize)

- (BOOL)isModal{
    if (self.navigationController != nil) {
        return NO;
    }
    return YES;
}

- (BOOL)isNavRootViewController{
    if(self.navigationController == nil){
        return NO;
    }
    
    UIViewController * pRoot	= [self.navigationController.viewControllers objectAtIndex:0];
    if (nil == pRoot || self == pRoot) {
        return YES;
    }
    return NO;
}


-(void)closeViewAnimated:(BOOL)animated{
    if([self isModal])
        [self dismissViewControllerAnimated:animated completion:nil];
    else {
        [self.navigationController popViewControllerAnimated:animated];
    }
}

- (UIButton*)buttonWithNavBackStyle:(NSString*)strTitle{
    return [self buttonWithNavBackStyle:strTitle withBtnImageName:@"btn_back.png"];
}

- (UIButton*)buttonWithNavBackStyle:(NSString*)strTitle withBtnImageName:(NSString *)strImgName {
    UIFont* font            = [UIFont boldSystemFontOfSize:14.0f];
    CGSize nSize            = [strTitle sizeWithFont:font];
    int nNewWidth           = nSize.width + 29 < 55 ? 55 : nSize.width + 26;
    
    UIButton* btn			= [[UIButton alloc] initWithFrame:CGRectMake(0,0,nNewWidth,kNavBtnHeight)];
    btn.titleLabel.font		= font;
    btn.titleLabel.shadowColor = [UIColor blackColor];
    btn.titleLabel.shadowOffset = CGSizeMake(0, -1.0);
    UIEdgeInsets edge = btn.titleEdgeInsets;
    edge.left +=5;
    btn.titleEdgeInsets = edge;
    
    [btn setTitle:strTitle forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return btn;
}

- (UIButton*)buttonWithNavLeftStyle:(NSString*)strTitle withBtnImageName:(NSString *)strImgName {
    UIFont* font            = [UIFont boldSystemFontOfSize:12.0f];
    CGSize nSize            = [strTitle sizeWithFont:font];
    int nNewWidth           = nSize.width + 25 < 52 ? 52 : nSize.width + 16;
    
    UIButton* btn			= [[UIButton alloc] initWithFrame:CGRectMake(0,0,nNewWidth,kNavBtnHeight)];
    btn.titleLabel.font		= font;
    btn.titleLabel.shadowColor = [UIColor blackColor];
    btn.titleLabel.shadowOffset = CGSizeMake(0, -1.0);
    UIEdgeInsets edge = btn.titleEdgeInsets;
    edge.left +=5;
    btn.titleEdgeInsets = edge;
    
    [btn setTitle:strTitle forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return btn;
}

- (UIButton*)buttonWithConfirmStyle:(NSString*)strTitle{
    return [self buttonWithConfirmStyle:strTitle imageName:nil];
}

- (UIButton*)buttonWithIcon:(NSString*)strImgName{
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0,0,44,kNavBtnHeight)];
    [button setImage:[UIImage imageNamed:strImgName] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
    return button;
}

- (UIButton*)buttonWithConfirmStyle:(NSString*)strTitle imageName:(NSString *)strImgName{
    UIFont* font            = [UIFont systemFontOfSize:16.0f];
    CGSize nSize            = [strTitle sizeWithFont:font];
    int nNewWidth           = nSize.width + 25 < 52 ? 52 : nSize.width + 16;
    //wujuan.begin
    if([StrUtils isEmpty:strTitle] && ![StrUtils isEmpty:strImgName]) {
        nNewWidth = 20.0f;
    }
    //wujuan.end
    UIButton* btn			= [[UIButton alloc] initWithFrame:CGRectMake(0,0,nNewWidth,kNavBtnHeight)];
    btn.tag  = kNavBtnTag;
    btn.titleLabel.font		= font;
    btn.titleLabel.shadowColor = [UIColor blackColor];
    btn.titleLabel.shadowOffset = CGSizeMake(0, -1.0);
    if (IS_IOS7_OR_LATER) {
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -20);
    }
    
    [btn setTitle:strTitle forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:strImgName] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(5, 10, 0, 5)];
    //wujuan.begin
    if([StrUtils isEmpty:strTitle] && ![StrUtils isEmpty:strImgName]) {
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,0)];
    }
    //wujuan.end
    return btn;
}



- (void)removeNavLeftButton{
    UIView *vi = [[UIView alloc] init];
    vi.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:vi];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)addNavConfirmButtonWithDefaultAction:(NSString*)strTitle{
    [self addNavConfirmButtonWithDefaultAction:strTitle backGroundImgName:nil];
}

- (void)addNavConfirmButtonWithIcon:(NSString *)strImgName{
    UIButton *btn = [self buttonWithIcon:strImgName];
    if (btn) {
        if (!IS_IOS7_OR_LATER) {
            [btn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            UIView * customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
            [customView addSubview:btn];
            btn.center = CGPointMake(30, 30);
            UIBarButtonItem* rItem	= [[UIBarButtonItem alloc] initWithCustomView:customView];
            self.navigationItem.rightBarButtonItem = nil;
            self.navigationItem.rightBarButtonItem = rItem;
        } else {
            [btn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem* rItem	= [[UIBarButtonItem alloc] initWithCustomView:btn];
            self.navigationItem.rightBarButtonItem = nil;
            self.navigationItem.rightBarButtonItem = rItem;
        }
    }
}

- (void)addNavConfirmButtonWithDefaultAction:(NSString*)strTitle backGroundImgName:(NSString *)strImgName{
    UIButton* btn;
    if (strImgName == nil) {
        btn = [self buttonWithConfirmStyle:strTitle];
    }else{
        btn = [self buttonWithConfirmStyle:strTitle imageName:strImgName];
    }
    if (btn) {
        [btn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* rItem	= [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = rItem;
    }
}

- (void)setConfirmButtonTitle:(NSString *)strTitle{
    UIButton *btn = (UIButton *)[self.navigationController.view viewWithTag:kNavBtnTag];
    [btn setTitle:strTitle forState:UIControlStateNormal];
}

- (void)setConfirmButtonEnabled:(BOOL)nEnabled{
    UIButton *btn = (UIButton *)[self.navigationController.view viewWithTag:kNavBtnTag];
    btn.enabled = nEnabled;
}


- (void)addNavConfirmButtonWithDefaultAction:(NSString*)strTitle iconImageName:(NSString *)strIconImgName{
    UIView *rView = [self viewWithConfirmStyle:strTitle iconImgName:strIconImgName];
    
    UIBarButtonItem* lItem	= [[UIBarButtonItem alloc] initWithCustomView:rView];
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = lItem;
}

- (void)addNavConfirmButtonWithDefaultAction:(NSString*)strTitle
                               iconImageName:(NSString *)strIconImgName
                         withBackGroundImage:(NSString*)bgImg{
    UIView *rView = [self viewWithConfirmStyle:strTitle iconImgName:strIconImgName withBackGroundImage:bgImg];
    
    UIBarButtonItem* lItem	= [[UIBarButtonItem alloc] initWithCustomView:rView];
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = lItem;
}

// wujuan.begin
- (void)addCanCelButtonWithAction:(NSString *)title
{
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 45.0f, 25.0f)];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [leftButton setTitle:title forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setTitleColor:RGB(168, 208, 251) forState:UIControlStateHighlighted];
    [leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [leftButton addTarget:self
                   action:@selector(cancelButtonClick:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}
//wujuan.end

- (UIView *)viewWithConfirmStyle:(NSString *)strTitle
                     iconImgName:(NSString *)strIconImgName{
    return [self viewWithConfirmStyle:strTitle iconImgName:strIconImgName withBackGroundImage:@"btn_next_blue.png"];
}

- (UIView *)viewWithConfirmStyle:(NSString *)strTitle
                     iconImgName:(NSString *)strIconImgName
             withBackGroundImage:(NSString*)strBgImg{
    UIFont* font            = [UIFont boldSystemFontOfSize:11.0f];
    CGSize nSize            = [strTitle sizeWithFont:font];
    
    UIImageView *iconImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:strIconImgName]];
    CGFloat imgWidth    = iconImgView.image.size.width /2.0f;
    CGFloat imgHeight   = iconImgView.image.size.height /2.0f;
    iconImgView.frame = CGRectMake(kNavBtnIconImgXMagin, (kNavBtnHeight - imgHeight)/2.0f, imgWidth , imgHeight);
    CGFloat labXMagin = CGRectGetMaxX(iconImgView.frame) + kNavBtnIconLabXMagin;
    UILabel *rLab = [[UILabel alloc] init];
    if (strTitle) {
        rLab.frame = CGRectMake(labXMagin, (kNavBtnHeight - nSize.height)/2.0f, nSize.width, nSize.height);
        rLab.text = strTitle;
        rLab.shadowColor    = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        rLab.shadowOffset   = CGSizeMake(0, -1);
        rLab.textColor      = [UIColor whiteColor];
        rLab.backgroundColor = [UIColor clearColor];
        rLab.font = font;
    }
    
    UIView *rView = [[UIView alloc] init];
    CGFloat rViewWidth = labXMagin + CGRectGetWidth(rLab.frame) + kNavBtnIconLabRightMagin;
    if (!strTitle) {
        rViewWidth -= 5;
    }
    rView.frame =  CGRectMake(0, 0, rViewWidth, kNavBtnHeight);
    UIButton* btn = [[UIButton alloc] initWithFrame:rView.frame];
    if (btn) {
        [rView addSubview:btn];
        [rView addSubview:iconImgView];
        [rView addSubview:rLab];
        
        
        [btn addTarget:self action:@selector(navLeftBtnItemClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return rView;
}



- (void)addNavCustomtitleView:(NSString*)strNick{
    
    if ([strNick length] <= 0 ) {
        return;
    }
    UILabel *label = (UILabel*)self.navigationItem.titleView;
    if (!label) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        label.font              = [UIFont  boldSystemFontOfSize:18];
        label.textColor         = [UIColor whiteColor];
        label.shadowColor       = RGB(129, 129, 129);
        label.backgroundColor   = [UIColor clearColor];
        label.shadowOffset      = CGSizeMake(0, -1);
        label.textAlignment     = NSTextAlignmentCenter;
        label.autoresizingMask  = UIViewAutoresizingFlexibleWidth;
        label.lineBreakMode     = NSLineBreakByTruncatingMiddle;
        self.navigationItem.titleView  = label;
    }
    label.text = strNick;
}

- (void)addNavBackButtonWithDefaultAction{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"general_icon_back.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"general_icon_back_highlight.png"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
}

//- (void)setTabBarItemBadgeView
//{
//    for (UIView* tabBarButton in self.tabBarController.tabBar.subviews) {
//        for (UIView* badgeView in tabBarButton.subviews) {
//            //            [badgeView setWidth:10];
//            //            [badgeView setHeight:10];
//            NSString* className = NSStringFromClass([badgeView class]);
//
//            // looking for _UIBadgeView
//            if ([className rangeOfString:@"BadgeView"].location != NSNotFound) {
//                badgeView.width = 8.f;
//                for (UIView* badgeSubview in badgeView.subviews) {
//                    NSString* className = NSStringFromClass([badgeSubview class]);
//                    // looking for _UIBadgeBackground
//                    if ([className rangeOfString:@"BadgeBackground"].location != NSNotFound) {
//                        @try {
//                            CGRect frame = badgeSubview.frame;
//                            frame.origin.y += 5.0;
//                            badgeSubview.frame = frame;
//                            [badgeSubview setValue:[UIImage imageNamed:@"redPoint"] forKey:@"image"];
//                        }
//                        @catch (NSException *exception) {}
//                    }
//
//                    if ([badgeSubview isKindOfClass:[UILabel class]]) {
//                        ((UILabel *)badgeSubview).textColor = [UIColor clearColor];
//                    }
//                }
//            }
//        }
//    }
//
//}

#pragma mark - action

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backBtnClick:(id)sender
{
    [self closeViewAnimated:YES];
}

- (void)confirmBtnClick:(id)sender
{
    
}

- (void)navLeftBtnItemClick:(id)sender
{
    
}

- (void)cancelButtonClick:(UIButton *)button
{
    
}

- (void)setViewInteraction
{
    if (self.tabBarController && (self.tabBarController.view.userInteractionEnabled == NO))
        self.tabBarController.view.userInteractionEnabled = YES;
    if (self.navigationController && (self.navigationController.view.userInteractionEnabled == NO))
        self.navigationController.view.userInteractionEnabled = YES;
    if (self.view.userInteractionEnabled == NO)
        self.view.userInteractionEnabled = YES;
}
- (void)resignResponder
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}
- (void)setRightBarButtonItemWithText:(NSString *)text imageName:(NSString *)image
{
    UIBarButtonItem *rigthBar;
    if (!text&&!image) {
        rigthBar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(barButtonItemAction:)];
    }else
    {
        UIButton *titleBT = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleBT setTitle:text forState:UIControlStateNormal];
        if (image) {
            [titleBT setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
            [titleBT setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
        }
        [titleBT setContentMode:UIViewContentModeRight];
        [titleBT setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [titleBT addTarget:self action:@selector(barButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
        titleBT.titleLabel.font = NavigationTitleFont;
        //        [titleBT setTitleEdgeInsets:UIEdgeInsetsMake(0, 80,0, 5)];
        //      [titleBT setImageEdgeInsets:UIEdgeInsetsMake(8, 0, 8, -80)];
        titleBT.frame = CGRectMake(0, 0, 120, 44);
        rigthBar = [[UIBarButtonItem alloc]initWithCustomView:titleBT];
        ;
    }
    
    self.navigationItem.rightBarButtonItem = rigthBar;
}
- (void)setLeftBarButtonItemWithText:(NSString *)text imageName:(NSString *)image respond:(void(^)(UIBarButtonItem *leftItem))action;
{
    
    self.title = @"";
    UIButton *titleBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBT setTitle:text forState:UIControlStateNormal];
    if (image) {
        [titleBT setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [titleBT setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    }else
    {
        [titleBT setImage:[UIImage imageNamed:@"ima_nav_left"] forState:UIControlStateNormal];
    }
    titleBT.titleLabel.textAlignment = NSTextAlignmentLeft;
    [titleBT setContentMode:UIViewContentModeLeft];
    [titleBT setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [titleBT addTarget:self action:@selector(barButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    titleBT.titleLabel.font = NavigationTitleFont;
    //    [titleBT setTitleEdgeInsets:UIEdgeInsetsMake(0, -80,0, 5)];
    //    [titleBT setImageEdgeInsets:UIEdgeInsetsMake(8, 0, 8, 0)];
    titleBT.frame = CGRectMake(0, 0, SCREENWIDTH-80, 44);
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:titleBT];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}
- (void)barButtonItemAction:(UIButton *)sender
{
    
}
@end
