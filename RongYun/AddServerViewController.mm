//
//  AddServerViewController.m
//  RongYun
//
//  Created by 乐米科技 on 5/21/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "AddServerViewController.h"
#import "ServerListViewController.h"
#import <ZXingWidgetController.h>

#import <QRCodeReader.h>
@interface AddServerViewController ()<ZXingDelegate>

@end

@implementation AddServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.m_tableView.tableFooterView = [[UIView alloc]init];
    [self setLeftBarButtonItemWithText:@"添加服务" imageName:IMAGENAME_BACK respond:nil];
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
        [titleBT setImage:[UIImage imageNamed:@"ima_nodate"] forState:UIControlStateNormal];
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
        }else
        {
            [titleBT setImage:[UIImage imageNamed:@"ima_nav_left"] forState:UIControlStateNormal];
        }
        [titleBT addTarget:self action:@selector(barButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
        titleBT.titleLabel.font = NavigationTitleFont;
        [titleBT setTitleEdgeInsets:UIEdgeInsetsMake(0, 80,0, 5)];
        [titleBT setImageEdgeInsets:UIEdgeInsetsMake(8, 0, 8, -80)];
        titleBT.frame = CGRectMake(0, 0, 120, 44);
        rigthBar = [[UIBarButtonItem alloc]initWithCustomView:titleBT];
        ;
    }
    
    self.navigationItem.rightBarButtonItem = rigthBar;
}
- (void)barButtonItemAction:(UIBarButtonItem *)barItem
{
    if (barItem ==self.navigationItem.rightBarButtonItem) {
        UITableViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"searchListViewController"];
        [self.navigationController pushViewController:viewController animated:YES];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==2) {
        ServerListViewController *serverVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ServerListViewController"];
        serverVC.type = SERVER_NEARBY;
        [self.navigationController pushViewController:serverVC animated:YES];
    }else if (indexPath.row ==1)
    {
        ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
        
        NSMutableSet *readers= [[NSMutableSet alloc] init];
        
        QRCodeReader*qrcodeReader = [[QRCodeReader alloc] init];
        
        [readers addObject:qrcodeReader];
        
        widController.readers = readers;
        
        [self presentViewController:widController animated:YES completion:^{}];
    }else if (indexPath.row ==0)
    {
        
    }
}

#pragma mark - ZXing delegate
- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result;
{
    
}
- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller;
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
