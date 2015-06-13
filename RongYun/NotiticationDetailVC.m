//
//  NotiticationDetailVC.m
//  RongYun
//
//  Created by 乐米科技 on 5/26/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "NotiticationDetailVC.h"

@interface NotiticationDetailVC ()

@end

@implementation NotiticationDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view sendSubviewToBack:self.errorView];
    [self.errorView setHidden:YES];
    self.isNeedRefreshUI = NO;
    self.typeLB.text = self.notificationEntity.m_title;
    self.dateLB.text = self.notificationEntity.m_date;
    self.contentLB.text = self.notificationEntity.m_content;
    [self setLeftBarButtonItemWithText:@"通知详情" imageName:IMAGENAME_BACK respond:nil];
}
- (void)barButtonItemAction:(UIButton *)barItem
{
    if (barItem ==self.navigationItem.rightBarButtonItem.customView) {
        
        
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
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
