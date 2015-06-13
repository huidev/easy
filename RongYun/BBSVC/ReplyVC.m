//
//  replyPostVC.m
//  RongYun
//
//  Created by apple on 15/5/23.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "ReplyVC.h"
#import "UserInfoSingleton.h"
@interface ReplyVC ()

@end

@implementation ReplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.view.backgroundColor = BGColor;
    self.errorView.hidden = YES;
    self.isNeedRefreshUI = NO;
    
    _textView = [[QEDTextView alloc] initWithFrame:CGRectMake(10, 10, MY_WIDTH-20, 144)];
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.delegate = self;
    _textView.textColor = TextColorPch;
    _textView.placeholder = @"想说点什么...";
    [self.view addSubview:_textView];

    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(next)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)next{

    switch (_replyType) {
        case ReplyPhoto:{
            //对照片发表评论
            NSDictionary *dic = @{@"otype":@"addc",@"u_id":[UserInfoSingleton sharedManager].u_id,@"u_name":[UserInfoSingleton sharedManager].u_name,@"u_ico":[UserInfoSingleton sharedManager].u_ico,@"c_content":_textView.text,@"c_is_comment":@"1"};
            [self requestGetWithRelativeUrl:URL_PHOTO_LIST parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"%@",responseObject);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@",task);
            }];
            break;
        }
        default:
            break;
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
