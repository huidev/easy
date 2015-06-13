//
//  ServerMainViewController.m
//  RongYun
//
//  Created by 乐米科技 on 5/13/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "ServerMainViewController.h"
#import "WHHttpClient.h"
#import "ServerListEntity.h"
#import "PopoverView.h"
#import "MapViewController.h"
#import <ZXingWidgetController.h>
#import <QRCodeReader.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
@interface ServerMainViewController ()<ZXingDelegate>
{
    
}
@end

@implementation ServerMainViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [WYPageManager sharedInstance].currentViewController = self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self allocData];
    [self configSubviews];
    [self requestData];
}

#pragma mark -private method
- (void)requestData
{
//    [SVProgressHUD showWithStatus:LOAD_MESSAGE];
}
- (void)allocData;
{
    
}
- (void)configSubviews;
{
    
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.view)]];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //    self.title = @"滑动切换视图";
    self.slideSwitchView.tabItemNormalColor = [SUNSlideSwitchView colorFromHexRGB:@"868686"];
    self.slideSwitchView.tabItemSelectedColor = [SUNSlideSwitchView colorFromHexRGB:@"bb0b15"];
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    
    self.homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    self.homeVC.s_id = self.s_id;
    self.homeVC.s_name = self.currentServer.s_name;
    self.homeVC.title = @"主页";
    self.homeVC.isAttented = YES;
    __block ServerMainViewController *weakSelf = self;
    self.homeVC.entireServerBlock = ^(ServerListEntity *item){
        weakSelf.currentServer = item;
    };
    
    self.weiZhanVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WeiZhanViewController"];
    self.weiZhanVC.title = @"微站";
    self.weiZhanVC.urlStr = self.currentServer.s_m_path;
    
    self.bbsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BBSViewController"];
    self.bbsVC.title = @"论坛";
    
    self.noticeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationViewController"];
    self.noticeVC.title = @"通知";
    [self setLeftBarButtonItemWithText:self.currentServer.s_name imageName:IMAGENAME_BACK respond:nil];
    [self setRightBarButtonItemWithText:nil imageName:@"service_cd"];
    UIButton *rightSideButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightSideButton setImage:[UIImage imageNamed:@"icon_rightarrow.png"] forState:UIControlStateNormal];
    [rightSideButton setImage:[UIImage imageNamed:@"icon_rightarrow.png"]  forState:UIControlStateHighlighted];
    rightSideButton.frame = CGRectMake(0, 0, 20.0f, 44.0f);
    rightSideButton.userInteractionEnabled = NO;
    //    self.slideSwitchView.rigthSideButton = rightSideButton;
    self.slideSwitchView.slideSwitchViewDelegate = self;
    [self.slideSwitchView buildUI];
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
- (void)barButtonItemAction:(UIButton *)sender
{
    if (sender ==self.navigationItem.rightBarButtonItem.customView) {
        CGPoint point = CGPointMake(sender.frame.origin.x + sender.frame.size.width/2+40, sender.frame.origin.y + sender.frame.size.height+20);
        NSArray *titles;
//        NSLog(@"%@",[_currentServer description]);
        if([self.currentServer.s_manager isEqualToString:@"admin"])
        {
            titles = @[@"扫一扫",@"取消关注",@"定位"];
        }else
            titles = @[@"取消关注", @"添加桌面快捷方式"];
//        NSArray *images = @[@"28b.png", @"28b.png", @"28b.png"];
        PopoverView *pop = [[PopoverView alloc] initWithPoint:point titles:titles images:nil];
        pop.selectRowAtIndex = ^(NSInteger index){
            NSString *selectStr = [titles objectAtIndex:index];
            if ([selectStr isEqualToString:@"取消关注"]) {
                [self cancelAttentionAction];
            }else if ([selectStr isEqualToString:@"扫一扫"])
            {
                ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
                
                NSMutableSet *readers= [[NSMutableSet alloc] init];
                
                QRCodeReader *qrcodeReader = [[QRCodeReader alloc] init];
                
                [readers addObject:qrcodeReader];
                
                widController.readers = readers;
                
                [self presentViewController:widController animated:YES completion:^{}];

            }else if ([selectStr isEqualToString:@"定位"])
            {
                
                MapViewController *mapVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MapViewController"];
                mapVC.type = MAP_LOCATION_EDIT;
                mapVC.local =CLLocationCoordinate2DMake([self.currentServer.s_position_x floatValue], [self.currentServer.s_position_y floatValue]);
                [self.navigationController pushViewController:mapVC animated:YES];
            }
        };
        [pop show];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)cancelAttentionAction
{
    UserEntity *user = [UserEntity sharedUserEntity];
    NSDictionary *param = @{@"otype":@"del",@"s_id":self.s_id?self.s_id:@"1",@"u_id":(user.u_id?user.u_id:@"1")};
    WHHttpClient *request = [WHHttpClient defaultClient];
    [request requestWithPath:URL_SERVER_LIST method:RTHttpRequestGet parameters:param prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (self.cancelAttentionBlock) {
            self.cancelAttentionBlock(self.s_id);
        }
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)tapErrorAction:(UITapGestureRecognizer *)gesture
{
    [self requestData];
    //    [self.view sendSubviewToBack:self.errorView];
    //    [self.view bringSubviewToFront:self.m_tableView];
}

#pragma network handler

#pragma mark - uitableView delegate


// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
//{
//    ServerListCell *cell = [tableView dequeueReusableCellWithIdentifier:SERVER_CELL];
//    if (!cell) {
//        cell = [[ServerListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SERVER_CELL];
//
//    }
//    ServerListEntity *entity = [[ServerListEntity alloc]init];
//    cell.model = entity;
//    return cell;
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}


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
- (NSUInteger)numberOfTab:(SUNSlideSwitchView *)view
{
    return 4;
}
- (NSString *)slideSwitchView:(SUNSlideSwitchView *)view titleOfTab:(NSUInteger)number;
{
    NSString *titleStr;
    if (number == 0) {
        return @"主页";
    } else if (number == 1) {
        return @"微站";
    } else if (number == 2) {
        return @"论坛";
    } else if (number == 3) {
        return @"通知";
    }else
    {
        return nil;
    }
    return titleStr;
}
- (UIViewController *)slideSwitchView:(SUNSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    if (number == 0) {
        return self.homeVC;
    } else if (number == 1) {
        return self.weiZhanVC;
    } else if (number == 2) {
        return self.bbsVC;
    } else if (number == 3) {
        return self.noticeVC;
    }else
    {
        return nil;
    }
}

- (void)slideSwitchView:(SUNSlideSwitchView *)view panLeftEdge:(UIPanGestureRecognizer *)panParam
{
    //    SUNViewController *drawerController = (SUNViewController *)self.navigationController.mm_drawerController;
    //    [drawerController panGestureCallback:panParam];
}

- (void)slideSwitchView:(SUNSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    BaseViewController *vc = nil;
    if (number == 0) {
        vc = self.homeVC;
    } else if (number == 1) {
//        [self.weiZhanVC loadWeiZhanView:self.currentServer.s_m_path];
        [self.weiZhanVC loadWeiZhanView:@"http://tybike.kuaizhan.com"];
        
        vc = self.weiZhanVC;
    } else if (number == 2) {
        vc = self.bbsVC;
    } else if (number == 3) {
        vc = self.noticeVC;
    }
//    self.title = vc.title;
    //    [vc viewDidCurrentView];
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

@end
