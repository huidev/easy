//
//  ConsumeViewController.m
//  RongYun
//
//  Created by 乐米科技 on 5/20/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "ConsumeViewController.h"
#import "ConsumEntity.h"
#import "ConsumCell.h"
@interface ConsumeViewController ()
{
    BOOL isRefresh;
}
@end

@implementation ConsumeViewController

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
    NSDictionary *param = @{@"otype":@"gete",@"s_id":self.s_id?@"1":@"1",@"u_id":(user.u_id?@"9":@"1"),@"index":@(1)};
    [self requestGetWithRelativeUrl:URL_SERVER_LIST parameters  :param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in responseObject)
            {
                ConsumEntity *entity = [[ConsumEntity alloc]initWithDict:dic];
                [self.dataArray addObject:entity];
            }

            [self.m_tableView reloadData];
            [SVProgressHUD dismiss];
        }
    } failure:nil];
//    [self requestPostWithRelativeUrl:URL_SERVER_LIST parameters:param prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        if ([responseObject isKindOfClass:[NSArray class]]) {
//            for (NSDictionary *dic in responseObject)
//            {
//                ConsumEntity *entity = [[ConsumEntity alloc]initWithDict:dic];
//                [self.dataArray addObject:entity];
//            }
//            
//            [self.m_tableView reloadData];
//            [SVProgressHUD dismiss];
//        }
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//    }];
}
- (void)allocData;
{
    [super allocData];
}
- (void)configSubviews;
{
    [super configSubviews];
    self.m_tableView.tableFooterView = [[UIView alloc]init];
    [self setLeftBarButtonItemWithText:@"消费记录" imageName:IMAGENAME_BACK respond:^(UIBarButtonItem *leftItem) {
        
    }];
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    sectionView.backgroundColor = [UIColor lightGrayColor];
    NSArray *arr = @[@"积分",@"扣减金额",@"会员卡号",@"时间"];
    for (int i=0; i<4; i++) {
        UILabel *itemLB = [[UILabel alloc]initWithFrame:CGRectMake(i*SCREENWIDTH/4, 0, SCREENWIDTH/2, 40)];
        itemLB.text = arr[i];
        itemLB.textAlignment = NSTextAlignmentCenter;
        [sectionView addSubview:itemLB];
    }
    return sectionView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.dataArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdent = @"cellIdent";
    
    ConsumCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    
    if (!cell) {
        cell = [[ConsumCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
        
    }
    ConsumEntity *entity = self.dataArray[indexPath.row];
    UILabel *valueLB1 = (UILabel *)[cell.contentView viewWithTag:10];
    valueLB1.text = [NSString stringWithFormat:@"%@",entity.s_integral];
    
    UILabel *valueLB2 = (UILabel *)[cell.contentView viewWithTag:11];
    valueLB2.text = [NSString stringWithFormat:@"%@",entity.s_money];
    UILabel *valueLB3 = (UILabel *)[cell.contentView viewWithTag:12];
    valueLB3.text = [NSString stringWithFormat:@"%@",entity.m_id];
    UILabel *valueLB4 = (UILabel *)[cell.contentView viewWithTag:13];
    valueLB4.text = entity.s_date;
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.consumModel = entity;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // ServerListViewController *listVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ServerListViewController"];
    
    UIViewController *controller = [[WYPageManager sharedInstance]getCurrentShowViewController];;
    
    [controller.navigationController pushViewController:nil animated:YES];
    
    
}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 0;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.5f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:1.5f];
}

#pragma mark - Refresh and load more methods

- (void) refreshTable
{
    /*
     
     Code to actually refresh goes here.
     
     */
    
    self.m_tableView.pullLastRefreshDate = [NSDate date];
    self.m_tableView.pullTableIsRefreshing = NO;
    [self.m_tableView setPullTableIsRefreshing:NO];
    [self requestData];
    isRefresh = YES;
}

- (void) loadMoreDataToTable
{
    /*
     
     Code to actually load more data goes here.
     
     */
    isRefresh = YES;
    self.m_tableView.pullTableIsLoadingMore = NO;
    [self.m_tableView setPullTableIsLoadingMore:NO];
    [self requestData];
    //    [self requestMoreFromIndex:[self.dataSource count] count:20];
    
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
