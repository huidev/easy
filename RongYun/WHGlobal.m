//
//  WHGlobal.m
//  RongYun
//
//  Created by 乐米科技 on 5/12/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "WHGlobal.h"
#import "CommInfo.h"
@implementation WHGlobal
+ (instancetype)shareInstance
{
    static WHGlobal *global;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        global = [[WHGlobal alloc] init];
        [global addKeyboardObserver];
    });
    return global;
}

- (void)dealloc
{
    [self removeKeyboardObserver];
}

+ (BOOL)isLogin{
    return ([[CommInfo getToken] length] > 0);
}

+ (void)loginOut{
    [CommInfo logout];
//    [[WHGlobal shareInstance].msgCountStore removeStore];
//    [WHGlobal shareInstance].msgCountStore = nil;
}
- (void)addKeyboardObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidDisappear)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidAppear)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
}

- (void)removeKeyboardObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
}

- (void)keyboardDidAppear
{
    self.hasShownKeyborad = YES;
}

- (void)keyboardDidDisappear
{
    self.hasShownKeyborad = NO;
}

@end
