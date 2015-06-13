//
//  WeiZhanViewController.m
//  RongYun
//
//  Created by 乐米科技 on 5/13/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "WeiZhanViewController.h"

@interface WeiZhanViewController ()<UIWebViewDelegate>

@end

@implementation WeiZhanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    
    // Do any additional setup after loading the view.
}
- (void)loadWeiZhanView:(NSString *)url;
{
    if (url&&![_urlStr isEqualToString:url]) {
        _urlStr = url;
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
        [self.webView loadRequest:request];
    }
   
}
- (void)configSubviews
{
//    [self.view sendSubviewToBack:self.errorView];
}
- (void)webViewDidStartLoad:(UIWebView *)webView;
{
    [SVProgressHUD showWithStatus:LOAD_MESSAGE];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    [SVProgressHUD dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
{
    [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
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
