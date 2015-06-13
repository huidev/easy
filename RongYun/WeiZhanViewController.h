//
//  WeiZhanViewController.h
//  RongYun
//
//  Created by 乐米科技 on 5/13/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseViewController.h"

@interface WeiZhanViewController : BaseViewController

@property (weak, nonatomic)IBOutlet UIWebView *webView;
@property (copy, nonatomic)NSString *urlStr;

- (void)loadWeiZhanView:(NSString *)url;
@end
