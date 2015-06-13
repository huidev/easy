//
//  LoginViewController.m
//  RongYun
//
//  Created by 乐米科技 on 5/10/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "LoginViewController.h"
#import "StrUtils.h"
#import "NSString+Utils.h"
#import "UserEntity.h"
#import "RCIM.h"
#import "RCDRCIMDataSource.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configSubviews];
}

- (void)configSubviews
{
    [super configSubviews];
    [self.view sendSubviewToBack:self.errorView];
    [self.view bringSubviewToFront:self.m_scrollView];
    self.isNeedRefreshUI = NO;
    self.title = @"用户登录";
    [self.savePasswordButton setImage:[UIImage imageNamed:@"rc_multi_choice_hover"] forState:UIControlStateSelected];
    if ([CommInfo getRememberPassword]) {
        self.savePasswordButton.selected = YES;
        self.accountField.text = [CommInfo loginUserName];
    }else
    {
        self.savePasswordButton.selected = NO;
    }
    [self.accountField createLeftImageView:@"login_ima_iphone"];
    [self.passwordField createLeftImageView:@"login_ima_pws"];
}
#pragma mark - Action
- (IBAction)loginButtonAction:(id)sender
{
    if (self.accountField.text.length) {
//        if([StrUtils checkMobileNumber:self.accountField.text] )
    }else
    {
        [SVProgressHUD showErrorWithStatus:ACCOUNT_MESSAGE];
        return;
    }
    if (self.passwordField.text.length) {
        //        if([StrUtils checkMobileNumber:self.accountField.text] )
    }else
    {
        [SVProgressHUD showErrorWithStatus:PASSWORD_MESSAGE];
        return;
    }
    if (self.savePasswordButton.selected) {
        [CommInfo setLoginUserName:self.accountField.text];
    }
    NSDictionary *param = @{@"otype":@"login",@"u_tel":self.accountField.text,@"u_login_pwd":[self.passwordField.text MD5]};
    [self requestGetWithRelativeUrl:URL_USER_LOGIN parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        [CommInfo setUserInformation:responseObject];
        [CommInfo setPassword:self.passwordField.text];
        UserEntity*user = [[UserEntity sharedUserEntity]initWithDict:responseObject];
            [self loginRongCould];
//        NSDictionary *param = @{@"otype":@"login",@"u_tel":user.u_tel?user.u_tel:self.accountField.text,@"u_login_pwd":[self.passwordField.text MD5]};
        if (self.loginSuccess) {
            self.loginSuccess();
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        if (self.loginSuccess) {
//            self.loginSuccess();
//        }
    }];

//    [self requestPostWithRelativeUrl:URL_USER_LOGIN parameters:param prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        [CommInfo setUserInformation:responseObject];
//        UserEntity*user = [[UserEntity sharedUserEntity]initWithDict:responseObject];;
//        if (self.loginSuccess) {
//            self.loginSuccess();
//        }
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//    }];
    
}
- (void)loginRongCould
{
    NSString *_deviceTokenCache = [[NSUserDefaults standardUserDefaults]objectForKey:kDeviceToken];
    
    //设置会话列表头像和会话界面头像
    [RCIM sharedKit].globalConversationPortraitSize = CGSizeMake(56, 56);
    [RCIM sharedKit].globalMessagePortraitSize = CGSizeMake(40, 40);
    //登陆融云服务器
    //token +hfEluLjZ78E1qo4hGRHcB01HLt4Xz13cunU1j3NdXlWsFs8Ixd36PRAul3lg==
    UserEntity *user = [UserEntity sharedUserEntity];
    [[RCIM sharedKit] initWithAppKey:RONGCLOUD_IM_APPKEY deviceToken:_deviceTokenCache];
    [[RCIM sharedKit] connectWithToken:user.token success:^(NSString *userId) {
        //保存默认用户
        //设置当前的用户信息
        RCUserInfo *_currentUserInfo = [[RCUserInfo alloc]initWithUserId:userId name:user.u_name portrait:nil];
        [RCIMClient sharedClient].currentUserInfo = _currentUserInfo;
        //同步群组
        [RCDDataSource syncGroups];
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
        
    } error:^(RCConnectErrorCode status) {
        // [hud setHidden:YES];
        NSLog(@"RCConnectErrorCode is %ld",(long)status);
    }];
}
- (IBAction)rememberPassword:(id)sender
{
    self.savePasswordButton.selected = !self.savePasswordButton.selected;
    [CommInfo setRememberPassword:self.savePasswordButton.selected];    
}
- (void)backClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)tapErrorAction:(UITapGestureRecognizer *)gesture
{
    [self.view sendSubviewToBack:self.errorView];
    [self.view bringSubviewToFront:self.m_scrollView];
}
#pragma mark -public method
- (void)leftBarButtonDisplay:(BOOL)flag;
{
    if (flag) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 40, 40);
        [backButton setTitle:@"取消" forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"general_icon_back.png"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"general_icon_back_highlight.png"] forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = backBarButtonItem;
    }else
    {
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
