//
//  WYPageManager.m
//  RongYun
//
//  Created by 乐米科技 on 5/9/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "WYPageManager.h"

@interface WYPageManager()

- (void)updateViewController:(UIViewController *)viewController withParam:(NSDictionary *)param;
- (UIViewController *)createViewControllerFromName:(NSString *)name param:(NSDictionary *)param;

@end

@implementation WYPageManager

#pragma mark - Life Cycle

- (void)dealloc
{
    
}

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}


#pragma mark - Public
#pragma mark Push To Navigation Controller

- (void)pushViewController:(NSString *)viewControllerName
{
    [self pushViewController:viewControllerName withParam:nil];
}

//qmx.begin
- (void)pushViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param
{
    [self pushViewController:viewControllerName withParam:param animated:YES];
}

- (void)pushViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param animated:(BOOL)animated
{
    UIViewController *viewController = [self createViewControllerFromName:viewControllerName param:param];
    if (!viewController) {
        return;
    }
    
    if (self.currentViewController.navigationController) {
        viewController.hidesBottomBarWhenPushed = YES;
        [self.currentViewController.navigationController pushViewController:viewController animated:animated];
    }
}
//qmx.end

//leon.begin
#pragma mark Pop View Controller

- (UIViewController*)popViewControllerWithParam:(NSDictionary*)param
{
    NSArray *viewControllers = self.currentViewController.navigationController.viewControllers;
    if([viewControllers count] < 2){
        return nil;
    }
    
    UIViewController *viewController = [viewControllers objectAtIndex:[viewControllers count] - 2];
    if(!viewController){
        return nil;
    }
    
    [self updateViewController:viewController withParam:param];
    return [self.currentViewController.navigationController popViewControllerAnimated:YES];
}

- (NSArray*)popToViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param
{
    if(viewControllerName == nil){
        return nil;
    }
    
    Class viewControllerClass = NSClassFromString(viewControllerName);
    if(viewControllerClass == nil){
        return nil;
    }
    
    __block UIViewController *viewController = nil;
    NSArray *viewControllers = self.currentViewController.navigationController.viewControllers;
    [viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        if([obj isKindOfClass:viewControllerClass]){
            viewController = obj;
            *stop = YES;
        }
    }];
    
    NSArray * resultAry = nil;
    if(viewController){
        [self updateViewController:viewController withParam:param];
        resultAry = [self.currentViewController.navigationController popToViewController:viewController
                                                                                animated:YES];
    }
    return resultAry;
}

//leon.end

//fly..begin

- (NSArray *)popToRootViewController:(NSDictionary *)param{
    __block UIViewController *viewController = nil;
    NSArray *viewControllers = self.currentViewController.navigationController.viewControllers;
    viewController = [viewControllers firstObject];
    
    NSArray * resultAry = nil;
    if(viewController){
        [self updateViewController:viewController withParam:param];
        resultAry = [self.currentViewController.navigationController popToViewController:viewController animated:NO];
    }
    return resultAry;
}


- (UIViewController*)getCurrentShowViewController{
    UIViewController* currentVC = [self.currentViewController.navigationController.viewControllers lastObject];
//    MLOG(@"currentVC->%@",NSStringFromClass([currentVC class]));
    return currentVC;
}

//fly..end

#pragma mark Present View Controller

- (void)presentViewController:(NSString *)viewControllerName
{
    [self presentViewController:viewControllerName withParam:nil];
}

- (void)presentViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param
{
    [self presentViewController:viewControllerName withParam:param inNavigationController:NO];
}

- (void)presentViewController:(NSString *)viewControllerName
                    withParam:(NSDictionary *)param
       inNavigationController:(BOOL)isInNavigationController
{
    [self presentViewController:viewControllerName
                      withParam:param
         inNavigationController:isInNavigationController
                       animated:YES];
}

- (void)presentViewController:(NSString *)viewControllerName
                    withParam:(NSDictionary *)param
       inNavigationController:(BOOL)isInNavigationController
                     animated:(BOOL)animated
{
    UIViewController *viewController = [self createViewControllerFromName:viewControllerName param:param];
    if (!viewController) {
        return;
    }
    
    if (isInNavigationController && self.currentViewController) {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [self.currentViewController.view.window.rootViewController presentViewController:navigationController animated:animated completion:nil];
    } else {
        [self.currentViewController presentViewController:viewController animated:animated completion:nil];
    }
}


#pragma mark - Private

- (void)updateViewController:(UIViewController *)viewController withParam:(NSDictionary *)param
{
    NSArray *keys = [param allKeys];
    if ([keys count] == 0) {
        return;
    }
    for (NSString *key in keys) {
        SEL selector = NSSelectorFromString(key);
        if (selector == 0) {
            continue;
        }
        
        if ([viewController respondsToSelector:selector]) {
            id value = [param objectForKey:key];
            [viewController setValue:value forKey:key];
        }
    }
}

- (UIViewController *)createViewControllerFromName:(NSString *)name param:(NSDictionary *)param
{
    if (param && ![param isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    Class class = NSClassFromString(name);
    if (!class || ![class isSubclassOfClass:[UIViewController class]]) {
        return nil;
    }
    
    UIViewController *viewController = nil;
    if (self.needNibFile) {
        viewController = [[class alloc] initWithNibName:name bundle:nil];
    } else {
        viewController = [[class alloc] init];
    }
    
    if (param) {
        [self updateViewController:viewController withParam:param];
    }
    
    return viewController;
}


@end
