//
//  registViewController.m
//  RongYun
//
//  Created by 乐米科技 on 5/16/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "registViewController.h"

@interface registViewController ()

@end

@implementation registViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configSubviews];
}

- (void)configSubviews
{
    [super configSubviews];
    [self.view sendSubviewToBack:self.errorView];
    self.m_scrollView.backgroundColor = [UIColor whiteColor];
    [self.view bringSubviewToFront:self.m_scrollView];
    self.isNeedRefreshUI = NO;
    self.title = @"用户注册";
    [self.mobileField createLeftImageView:@"login_ima_iphone"];
    [self.passwordField createLeftImageView:@"login_ima_pws"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -userAction
- (IBAction)getAuthButtonAction:(UIButton *)sender
{
    if (self.mobileField.text.length) {
        //        if([StrUtils checkMobileNumber:self.accountField.text] )
    }else
    {
        [SVProgressHUD showErrorWithStatus:ACCOUNT_MESSAGE];
        return;
    }
    NSDictionary *param = @{@"u_tel":self.mobileField.text,@"u_pwd":self.passwordField.text,@"otype":@"add"};
    [self requestPostWithRelativeUrl:URL_USER_LOGIN parameters:param prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [CommInfo setUserInformation:responseObject];
            UserEntity*user = [[UserEntity sharedUserEntity]initWithDict:responseObject];;
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}

- (IBAction)RegistButtonAction:(id)sender
{
    if (self.mobileField.text.length) {
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
    
    NSDictionary *param = @{@"u_tel":self.mobileField.text,@"u_pwd":self.passwordField.text,@"otype":@"add"};
    [self requestGetWithRelativeUrl:URL_USER_LOGIN parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [CommInfo setUserInformation:responseObject];
            UserEntity*user = [[UserEntity sharedUserEntity]initWithDict:responseObject];;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
//    [self requestPostWithRelativeUrl:URL_USER_LOGIN parameters:param prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            [CommInfo setUserInformation:responseObject];
//            UserEntity*user = [[UserEntity sharedUserEntity]initWithDict:responseObject];;
//        }
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//    }];
}
- (IBAction)rememberPassword:(id)sender
{
    self.protocolBT.selected = !self.protocolBT.selected;
    
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
