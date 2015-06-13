//
//  HomeViewController.m
//  RongYun
//
//  Created by 乐米科技 on 5/13/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "HomeViewController.h"
#import "InfoMoreCell.h"
#import "InfoNormalCell.h"
#import "ServerListEntity.h"
#import "ServerListViewController.h"
#import "WYPageManager.h"
#import "cardViewController.h"
#import "VIPCardViewController.h"
#import "RCDChatViewController.h"
#import "RCConversationModel.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "MapViewController.h"
#import <BaiduMapAPI/BMapKit.h>
@interface HomeViewController ()
{
    
    NSArray *constArray;
//    ServerListEntity *currentServer;
    NSMutableArray *recommendServer;
    NSMutableArray *recomArray;
}
@end

@implementation HomeViewController

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
    //    NSString *url = [[NSString stringWithFormat:@"http://%@/%@",SERVER_HOST,URL_SERVER_LIST] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSDictionary *param = @{@"otype":@"gets",@"s_id":self.s_id?self.s_id:@"1"};
    WHHttpClient *httpClient = [WHHttpClient defaultClient];
    [httpClient requestWithPath:URL_SERVER_LIST method:RTHttpRequestGet     parameters:param prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            ServerListEntity *entity = [[ServerListEntity alloc]initWithDict:responseObject];
            if (!entity.s_desc) {
                entity.s_desc = entity.s_intro;
            }
            [self displayViewWithData:entity];
//            [recommendServer addObject:currentServer];
//            [recomArray addObject:@{@"image":entity.s_ico,@"title":entity.s_name}];
            [SVProgressHUD dismiss];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    }];
    NSDictionary *param1 = @{@"otype":@"getr",@"s_id":self.s_id?self.s_id:@"1"};
    
    [self requestGetWithRelativeUrl:URL_SERVER_LIST parameters:param1 success:^(NSURLSessionDataTask *task, id responseObject) {
        for (NSDictionary *item in responseObject)
        {
            ServerListEntity *entity = [[ServerListEntity alloc]initWithDict:item];
            if (!entity.s_desc) {
                entity.s_desc = entity.s_intro;
            }
            [recommendServer addObject:entity];
            [recomArray addObject:@{@"image":entity.s_ico,@"title":entity.s_name}];
        }
        [self.m_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:5 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        [SVProgressHUD dismiss];
    } failure:nil];
}
- (void)allocData;
{
    [super allocData];
    recommendServer = [NSMutableArray array];
    recomArray = [NSMutableArray array];
    constArray = @[@[@"简介",@"About Company",@"admin"],@[@"地址",@"Address",@"beijin"],@[@"客服",@"Customer Server",@"点击联系客服"],@[@"卡券",@"Coupons",@"卡券"],@[@"会员卡",@"Memember Card",@"会员"],@[@"推荐",@"Recommended SP",@"没有"]];
    //    self.dataArray = @[@"1",@"2",@"3",@"4",@"5"];
}
- (void)configSubviews;
{
    [super configSubviews];
    if (self.isAttented) {
        self.attentionBT.hidden = YES;
    }else
    {
        self.attentionBT.hidden = NO;
        [self setLeftBarButtonItemWithText:@"关注服务商" imageName:IMAGENAME_BACK respond:nil];
        self.navigationItem.rightBarButtonItem  = nil;
    }
    self.logoImageview.layer.cornerRadius = self.logoImageview.frame.size.width/2;
    [self.logoImageview.layer setMasksToBounds:YES];
    
//    self.m_tableView.estimatedRowHeight = 80;
//    self.m_tableView.rowHeight = UITableViewAutomaticDimension;
//        [self setLeftBarButtonItemWithText:self.s_name imageName:IMAGENAME_BACK respond:nil];
//        [self setRightBarButtonItemWithText:nil imageName:@"service_cd"];
    //在storyboard设cell 的identity
    //    [self.m_tableView registerNib:[ServerListCell serverListCellNib] forCellReuseIdentifier:SERVER_CELL];
}

- (void)barButtonItemAction:(UIButton *)barItem
{
    if (barItem ==self.navigationItem.rightBarButtonItem.customView) {
        UITableViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"searchListViewController"];
        [self.navigationController pushViewController:viewController animated:YES];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)tapErrorAction:(UITapGestureRecognizer *)gesture
{
    [self requestData];
    //    [self.view sendSubviewToBack:self.errorView];
    //    [self.view bringSubviewToFront:self.m_tableView];
}
- (void)displayViewWithData:(ServerListEntity *)entity
{
    _currentServer = entity;
    if (self.entireServerBlock) {
        self.entireServerBlock(_currentServer);
    }
    [self.logoImageview setImageWithURL:[NSURL URLWithString:_currentServer.s_ico] placeholderImage:nil];
    self.typeLB.text = entity.s_type;
    self.nameLB.text = entity.s_name;
    [self.m_tableView reloadData];
}
- (IBAction)functionButtonAction:(UIButton *)sender
{
    if (sender.tag==100) {
        UIViewController *controller = [[WYPageManager sharedInstance]getCurrentShowViewController];;
        MapViewController *mapVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MapViewController"];
        
        mapVC.local =CLLocationCoordinate2DMake([self.currentServer.s_position_x floatValue], [self.currentServer.s_position_y floatValue]);
        [controller.navigationController pushViewController:mapVC animated:YES];
        
    }else if (sender.tag==101)
    {
        NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        
        //        NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"It's A Popup!" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
        
        NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:@"说明" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor blackColor],NSParagraphStyleAttributeName : paragraphStyle}];
        //        UIImage *icon = [UIImage imageNamed:@"icon"];
        
        NSString *imageName = @"ima_renzhen_1";
        
        NSAttributedString *lineOne1 = [[NSAttributedString alloc] initWithString:@"全称" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor blackColor],NSParagraphStyleAttributeName : paragraphStyle}];
        
        NSAttributedString *lineOne2 = [[NSAttributedString alloc] initWithString:@"服务范围" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor blackColor],NSParagraphStyleAttributeName : paragraphStyle}];
        //        UIImage *icon = [UIImage imageNamed:@"icon"];
        
        NSString *imageName1 = @"ima_renzhen_2";
        
        NSAttributedString *lineOne3 = [[NSAttributedString alloc] initWithString:@"时间" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor blackColor],NSParagraphStyleAttributeName : paragraphStyle}];
        //        UIImage *icon = [UIImage imageNamed:@"icon"];
        
        NSString *imageName2 = @"ima_renzhen_3";
        NSAttributedString *lineTwo = [[NSAttributedString alloc] initWithString:_currentServer.s_identification_des attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor grayColor], NSParagraphStyleAttributeName : paragraphStyle}];
        
        NSAttributedString *lineTwo1 = [[NSAttributedString alloc] initWithString:_currentServer.s_name attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor grayColor], NSParagraphStyleAttributeName : paragraphStyle}];
        NSAttributedString *lineTwo2 = [[NSAttributedString alloc] initWithString:_currentServer.s_type attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor grayColor], NSParagraphStyleAttributeName : paragraphStyle}];
        
        NSAttributedString *lineTwo3 = [[NSAttributedString alloc] initWithString:_currentServer.s_identification_date attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor grayColor], NSParagraphStyleAttributeName : paragraphStyle}];
//        NSAttributedString *lineTwo = [[NSAttributedString alloc] initWithString:@"With style, using NSAttributedString" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSForegroundColorAttributeName : [UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0], NSParagraphStyleAttributeName : paragraphStyle}];
        
        //        NSAttributedString *buttonTitle = [[NSAttributedString alloc] initWithString:@"Close me" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName : [UIColor whiteColor], NSParagraphStyleAttributeName : paragraphStyle}];
        
        CNPPopupController *popupController = [[CNPPopupController alloc] initWithTitle:nil contents:@[@{@"titleImage":imageName,@"titleText":lineOne}, lineTwo,@{@"titleImage":imageName1,@"titleText":lineOne1},lineTwo1,lineOne2,lineTwo2,@{@"titleImage":imageName2,@"titleText":lineOne3},lineTwo3] buttonTitles:nil destructiveButtonTitle:nil];
        popupController.leftSpace = 30;
        popupController.theme = [CNPPopupTheme defaultTheme];
        //        popupController.theme.popupStyle = popupStyle;
        popupController.theme.presentationStyle = CNPPopupPresentationStyleSlideInFromTop;
        popupController.theme.dismissesOppositeDirection = YES;
        popupController.delegate = self;
        [popupController presentPopupControllerAnimated:YES];
        
    }else if (sender.tag==102)//电话
    {
        [[[UIAlertView alloc] initWithTitle:nil
                                    message:_currentServer.s_tel
                                   delegate:self
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:@"呼叫", nil] show];
    }else if (sender.tag==103)//二维码
    {
        NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        
//        NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"It's A Popup!" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
        
        NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:_currentServer.s_name attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor blackColor],NSParagraphStyleAttributeName : paragraphStyle}];
//        UIImage *icon = [UIImage imageNamed:@"icon"];
        
        NSString *imageName = _currentServer.s_two_dimension_img;
        NSAttributedString *lineTwo = [[NSAttributedString alloc] initWithString:@"扫一扫上面的二维码图案，可加该服务商" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor lightGrayColor], NSParagraphStyleAttributeName : paragraphStyle}];
//        NSAttributedString *lineTwo = [[NSAttributedString alloc] initWithString:@"With style, using NSAttributedString" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSForegroundColorAttributeName : [UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0], NSParagraphStyleAttributeName : paragraphStyle}];
        
//        NSAttributedString *buttonTitle = [[NSAttributedString alloc] initWithString:@"Close me" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName : [UIColor whiteColor], NSParagraphStyleAttributeName : paragraphStyle}];
        
        CNPPopupController *popupController = [[CNPPopupController alloc] initWithTitle:nil contents:@[@{@"titleImage":_currentServer.s_ico,@"titleText":lineOne}, imageName, lineTwo] buttonTitles:nil destructiveButtonTitle:nil];
        popupController.theme = [CNPPopupTheme defaultTheme];
//        popupController.theme.popupStyle = popupStyle;
        popupController.theme.presentationStyle = CNPPopupPresentationStyleSlideInFromTop;
        popupController.theme.dismissesOppositeDirection = YES;
        popupController.delegate = self;
        [popupController presentPopupControllerAnimated:NO];
    }else if (sender.tag==104)//关注
    {
        UserEntity *user = [UserEntity sharedUserEntity];
        NSDictionary *param = @{@"otype":@"add",@"s_id":self.s_id?self.s_id:@"1",@"u_id":user.u_id?user.u_id:@"1"};
        WHHttpClient *httpClient = [WHHttpClient defaultClient];
        [httpClient requestWithPath:URL_SERVER_LIST method:RTHttpRequestGet     parameters:param prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
             {
                if (self.attendionServerBlock) {
                    self.attendionServerBlock(self.currentServer);
                }
                [SVProgressHUD dismiss];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];

    }else if (sender.tag==105)
    {
        
    }
}

#pragma mark - CNPPopupController Delegate

- (void)popupController:(CNPPopupController *)controller didDismissWithButtonTitle:(NSString *)title {
    NSLog(@"Dismissed with button title: %@", title);
}

- (void)popupControllerDidPresent:(CNPPopupController *)controller {
    NSLog(@"Popup controller presented.");
}
#pragma mark -alert delegate

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex==1) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[_currentServer.s_tel stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]]];
    }
}
#pragma network handler

#pragma mark - uitableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return constArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdent = @"cellNormal";
    static NSString *cellMoreIdent = @"cellMore";
    if (indexPath.row<constArray.count-1) {
        InfoNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
        
        if (!cell) {
            cell = [[InfoNormalCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
            
        }
        if(indexPath.row>1)
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        NSArray *arr = [constArray objectAtIndex:indexPath.row];
        cell.titleLB.text = arr[0];
        cell.subtitleLB.text = arr[1];
        if (indexPath.row==0) {
            [cell.contentBT setTitle:_currentServer.s_intro forState:UIControlStateNormal];
        }else if (indexPath.row==1)
        {
            [cell.contentBT setTitle:_currentServer.s_address forState:UIControlStateNormal];
        }else if (indexPath.row ==2)
        {
            [cell.contentBT setTitle:@"点击联系客服" forState:UIControlStateNormal];
        }else if (indexPath.row ==3)
        {
            [cell.contentBT setImage:[[UIImage imageNamed:@"yhj"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        }else if (indexPath.row==4)
        {
            [cell.contentBT setImage:[[UIImage imageNamed:@"vip64"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        }
        
        return cell;
        
    }else
    {
        InfoMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellMoreIdent];
        
        if (!cell) {
            cell = [[InfoMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellMoreIdent];
            
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSArray *arr = [constArray objectAtIndex:indexPath.row];
        cell.titleLB.text = arr[0];
        cell.subtitleLB.text = arr[1];
        cell.dataArray = recomArray;
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *controller = [[WYPageManager sharedInstance]getCurrentShowViewController];;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (recommendServer.count&&indexPath.row==5) {
        ServerListViewController *listVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ServerListViewController"];
        listVC.dataArray = [NSMutableArray arrayWithArray:recommendServer];
        listVC.type = SERVER_RECOMMEND;

        [controller.navigationController pushViewController:listVC animated:YES];
    }else if (indexPath.row==3)
    {
        cardViewController *cardVC = [self.storyboard instantiateViewControllerWithIdentifier:@"cardViewController"];
        cardVC.s_id = self.s_id;
        [controller.navigationController pushViewController:cardVC animated:YES];
    }else if (indexPath.row ==4)
    {
        VIPCardViewController *cardVC = [self.storyboard instantiateViewControllerWithIdentifier:@"VIPCardViewController"];
//        cardVC.s_id = self.s_id;
        [controller.navigationController pushViewController:cardVC animated:YES];
    }else if (indexPath.row ==2)
    {
        // 创建客服聊天视图控制器。
        RCDChatViewController *_conversationVC = [[RCDChatViewController alloc]init];
        RCConversationModel *model = [[RCConversationModel alloc]init];
        model.targetId = self.currentServer.s_c_id;
        model.conversationTitle = self.currentServer.s_name;
        _conversationVC.conversationType = model.conversationType;
        _conversationVC.targetId = model.targetId;
        _conversationVC.targetName = model.conversationTitle;
        _conversationVC.title = model.conversationTitle;
        _conversationVC.conversation = model;
        // 把客服聊天视图控制器添加到导航栈。
        [controller.navigationController pushViewController:_conversationVC animated:YES];
    }else
    {
        MapViewController *mapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
        [controller.navigationController pushViewController:mapVC animated:YES];
    }
    
}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 0;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_currentServer) {
        return 60;
    }
    CGRect rect;
    if (indexPath.row==0) {
        rect = [_currentServer.s_intro boundingRectWithSize:CGSizeMake(SCREENWIDTH*2/3, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT_CELL_SMALL} context:nil];
        
    }else if (indexPath.row==1)
    {
        rect = [_currentServer.s_address boundingRectWithSize:CGSizeMake(SCREENWIDTH*2/3, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT_CELL_SMALL} context:nil];
        
    }else if (indexPath.row ==2)
    {
        rect = [@"点击联系客服" boundingRectWithSize:CGSizeMake(SCREENWIDTH*2/3-60, MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:FONT_CELL_SMALL}
                                                  context:nil];
    }else if (indexPath.row ==3)
    {
        rect = [_currentServer.s_intro boundingRectWithSize:CGSizeMake(SCREENWIDTH*2/3, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT_CELL_SMALL} context:nil];
        
    }else if (indexPath.row==4)
    {
        rect = [_currentServer.s_intro boundingRectWithSize:CGSizeMake(SCREENWIDTH*2/3, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT_CELL_SMALL} context:nil];
        
    }else if (indexPath.row ==5)
    {
        return MAX(ceilf( recommendServer.count/5.0)*60+10, 60);
        
    }

    return MAX(rect.size.height, 30)+30;
}
#pragma mark -uitableView delegate
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
