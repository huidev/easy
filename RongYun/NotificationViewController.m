//
//  NotificationViewController.m
//  RongYun
//
//  Created by 乐米科技 on 5/13/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "NotificationViewController.h"
#import "NotiticationDetailVC.h"
@interface NotificationViewController ()
{
    BOOL isRefresh;
}
@end

@implementation NotificationViewController

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
    NSDictionary *param = @{@"otype":@"getms",@"s_id":self.s_id?self.s_id:@"1",@"u_id":(user.u_id?user.u_id:@"1"),@"index":@(self.dataArray.count?self.dataArray.count:1)};
    [self requestGetWithRelativeUrl:URL_SERVER_LIST parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in responseObject)
            {
                NotificationEntity *entity = [[NotificationEntity alloc]initWithDict:dic];
                [self.dataArray addObject:entity];
            }
            
            [self.pullView reloadData];
            [SVProgressHUD dismiss];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    //    [self requestPostWithRelativeUrl:URL_SERVER_LIST parameters:param prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
    //
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
    
    self.pullView.tableFooterView = [[UIView alloc]init];
    [self setRightBarButtonItemWithText:@"我的" imageName:nil];
    [self setLeftBarButtonItemWithText:@"优惠券" imageName:IMAGENAME_BACK respond:nil];
}
- (void)barButtonItemAction:(UIButton *)barItem
{
    if (barItem ==self.navigationItem.rightBarButtonItem.customView) {
        
        
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
- (void)requestDeleteNotification:(NSIndexPath*)index finished:(void(^)(void))finished
{
    NotificationEntity *item = [self.dataArray objectAtIndex:index.row];
    UserEntity *user = [UserEntity sharedUserEntity];
    NSDictionary *param = @{@"otype":@"delms",@"m_id":item.m_id?STRING_FORM_OBJ(item.m_id):@"1",@"u_id":(user.u_id?user.u_id:@"1")};
    [self requestGetWithRelativeUrl:URL_MESSAGE parameters:param success:^(NSURLSessionDataTask *task, id responseObject)
     {
         finished();
     }failure:nil];
}

#pragma mark - uitableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.dataArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdent = @"cellIdent";
    
    NotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    
    if (!cell) {
        cell = [[NotificationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
        
    }
    NotificationEntity *entity = self.dataArray[indexPath.row];
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.entity = entity;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *controller = [[WYPageManager sharedInstance]getCurrentShowViewController];;
    NotiticationDetailVC *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NotiticationDetailVC"];
    detailVC.notificationEntity = self.dataArray[indexPath.row];
    [controller.navigationController pushViewController:detailVC animated:YES];
    //        UIViewController *controller = [[WYPageManager sharedInstance]getCurrentShowViewController];;
    //
    //        [controller.navigationController pushViewController:nil animated:YES];
    
    
}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 0;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 93;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        [self requestDeleteNotification:indexPath finished:^{
            [self.dataArray removeObjectAtIndex:indexPath.row];
            [self.pullView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return UITableViewCellEditingStyleDelete;
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
    
    self.pullView.pullLastRefreshDate = [NSDate date];
    self.pullView.pullTableIsRefreshing = NO;
    [self.pullView setPullTableIsRefreshing:NO];
    [self requestData];
    isRefresh = YES;
}

- (void) loadMoreDataToTable
{
    /*
     
     Code to actually load more data goes here.
     
     */
    isRefresh = YES;
    self.pullView.pullTableIsLoadingMore = NO;
    [self.pullView setPullTableIsLoadingMore:NO];
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
