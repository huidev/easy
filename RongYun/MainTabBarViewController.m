//
//  MainTabBarViewController.m
//  RongYun
//
//  Created by 乐米科技 on 5/9/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "ServerListViewController.h"
#import "BBSViewController.h"
#import "ChatViewController.h"
#import "AboutMeViewController.h"
@implementation MainTabBarViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
    
}
- (void)awakeFromNib
{
    [self initTabBarItem];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarController.delegate = self;
    
}
#pragma mark - Update the way to init tab bar item
- (void)initTabBarItem
{
    [self.tabBar setBarTintColor:[UIColor yellowColor]];
    NSArray *images = @[@"ico_s",@"ico.f", @"ico_m", @"ico_me"];
    NSArray *selectedImages = @[@"ico_s_over",@"ico_f_over", @"ico_m_over", @"ico_me_over"];
    NSArray *titles = @[@"服务",@"论坛",@"聊天",@"我"];
    for (int i = 0; i < [self.tabBar.items count]; i++) {
        UITabBarItem *tabBarItem = self.tabBar.items[i];
        UIImage *image = [UIImage imageNamed:images[i]];
        UIImage *selectedImage = [UIImage imageNamed:selectedImages[i]];
        if ([image respondsToSelector:@selector(imageWithRenderingMode:)] )
        {
            image =[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        if ([selectedImage respondsToSelector:@selector(imageWithRenderingMode:)]) {
            selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        if (IS_IOS7_OR_LATER) {
             tabBarItem = [tabBarItem initWithTitle:titles[i] image:image selectedImage:selectedImage];
           
        }else
        {
            [tabBarItem setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:image];
        }
       
        
    }
    
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item;
{
    if ([[tabBar items]objectAtIndex:3] == item) {
        [WYAPP presentLoginViewController];
    }
}
- (BOOL)tabBarController:(UITabBarController *)theTabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
    if ([[theTabBarController viewControllers] objectAtIndex:4] == viewController) {
//        if (![[WYGlobal shareInstance] isLogin]) {
//            [WYAPP presentLoginViewController];
//            return NO;
//        }
        [WYAPP presentLoginViewController];
        //        if ([[CommInfo getAppHelp] isEqualToString:@""] &&
        //            [[theTabBarController viewControllers] objectAtIndex:1] == viewController ) {
        //            [self showAppHelp];
        //            return YES;
        //        }
    }
    
    
    //    if ([[theTabBarController viewControllers] objectAtIndex:1] == viewController) {
    //        self.patientItem.badgeValue = nil;
    //    }else if ([[theTabBarController viewControllers] objectAtIndex:2] == viewController){
    //        self.friendItem.badgeValue = nil;
    //    }else if ([[theTabBarController viewControllers] objectAtIndex:0] == viewController){
    //        self.messageItem.badgeValue = nil;
    //    }
    
    //     if ([[theTabBarController viewControllers] objectAtIndex:1] == viewController) {
    //         [[WYGlobal shareInstance].msgCountStore setUnreadConsultFlag:0];
    //     }
    return YES;
}

@end
