//
//  VIPCardViewController.m
//  RongYun
//
//  Created by 乐米科技 on 5/20/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "VIPCardViewController.h"
#import "UserEntity.h"
#import "CreditEntity.h"
#import "ConsumeViewController.h"
#import "cardViewController.h"
#import "MyCardViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
@interface VIPCardViewController ()
{
    CreditEntity *currentCredit;
}
@end

@implementation VIPCardViewController

- (void)viewDidLoad {
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
    UserEntity *user = [UserEntity sharedUserEntity];
    NSDictionary *param = @{@"otype":@"getm",@"s_id":self.s_id?self.s_id:@"1",@"u_id":(user.u_id?user.u_id:@"1")};
//    [self requestPostWithRelativeUrl:URL_SERVER_LIST parameters:param prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            CreditEntity *entity = [[CreditEntity alloc]initWithDict:responseObject];
//            [self refreshSubview:entity];
//            
//            [SVProgressHUD dismiss];
//        }
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//    }];
    [self requestGetWithRelativeUrl:URL_SERVER_LIST parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            CreditEntity *entity = [[CreditEntity alloc]initWithDict:responseObject];
            [self refreshSubview:entity];
            
        }
    } failure:nil];
}
- (void)allocData;
{
    [super allocData];
}
- (void)configSubviews;
{
    [super configSubviews];
    [self setLeftBarButtonItemWithText:@"会员卡" imageName:IMAGENAME_BACK respond:nil];
    self.m_tableView.tableFooterView = [[UIView alloc]init];
    self.cardImageView.layer.cornerRadius = 15;
    self.cardImageView.layer.masksToBounds = YES;
    
    self.levelView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.levelView.layer.borderWidth = 1;
    self.creditView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.creditView.layer.borderWidth = 1;
    self.balanceView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.balanceView.layer.borderWidth = 1;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureAction:)];
    self.cardImageView.userInteractionEnabled = YES;
    self.cardImageView.tag = 10;
    [self.cardImageView addGestureRecognizer:tap];
    
}
- (void)gestureAction:(UIGestureRecognizer *)gesture
{
    UIImageView *imageV = (UIImageView *)gesture.view;
    if (imageV.tag==10) {
        [self.cardImageView setImageWithURL:[NSURL URLWithString:currentCredit.m_ico] placeholderImage:IMAGE_HOLD];
        imageV.tag = 11;
    }else
    {
        [self.cardImageView setImageWithURL:[NSURL URLWithString:currentCredit.m_ico] placeholderImage:IMAGE_HOLD];
        imageV.tag = 10;
    }
}
- (void)refreshSubview:(CreditEntity *)credit
{
    currentCredit = credit;
    [self.m_tableView reloadData];
    [self.cardImageView setImageWithURL:[NSURL URLWithString:credit.m_ico] placeholderImage:IMAGE_HOLD];
    self.levelLB.text = credit.m_t_name;
    self.creditLB.text = [NSString stringWithFormat:@"%@",credit.m_integral];
    self.balanceLB.text = [NSString stringWithFormat:@"%@",credit.m_balance];
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


#pragma mark - uitableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 3;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdent = @"cellIdent";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    UILabel *desLB = (UILabel *)[cell.contentView viewWithTag:10];
    UILabel *valueLB = (UILabel *)[cell.contentView viewWithTag:11];
    if (indexPath.row==0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        desLB.text = @"会员权利";
        valueLB.text = currentCredit.m_right;
    }else if (indexPath.row==1)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        desLB.text = @"消费记录";
        valueLB.text = @"信息";
    }else if (indexPath.row ==2)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        desLB.text = @"优惠券";
        valueLB.text = @"信息";
    }
    
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.cardEntity = entity;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // ServerListViewController *listVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ServerListViewController"];
    if (indexPath.row==2) {
        MyCardViewController *cardVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyCardViewController"];
        cardVC.s_id = currentCredit.u_id;
        [self.navigationController pushViewController:cardVC animated:YES];
    }else if (indexPath.row==1)
    {
        ConsumeViewController *consumeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ConsumeViewController"];
        consumeVC.s_id = currentCredit.u_id;
        [self.navigationController pushViewController:consumeVC animated:YES];
    }
//    UIViewController *controller = [[WYPageManager sharedInstance]getCurrentShowViewController];;
//    
//    [controller.navigationController pushViewController:nil animated:YES];
    
    
}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 0;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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
