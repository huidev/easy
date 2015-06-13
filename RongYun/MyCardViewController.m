//
//  MyCardViewController.m
//  RongYun
//
//  Created by 乐米科技 on 5/23/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "MyCardViewController.h"
#import "CardListEntity.h"
#import "CardListCell.h"
#import "UserCardEntity.h"
#import "CardDetailViewController.h"
#import "ZWHSegmentedControl.h"
@interface MyCardViewController ()
{
    BOOL isRefresh;
    NSMutableArray *expireArr;
    NSMutableArray *unuseArr;
}
@end

@implementation MyCardViewController

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
    if (isRefresh) {
        [self.dataArray removeAllObjects];
    }
    UserEntity *user = [UserEntity sharedUserEntity];
    NSDictionary *param = @{@"otype":@"list",@"s_id":self.s_id?self.s_id:@"1",@"u_id":(user.u_id?@"3":@"1")};
    [self requestGetWithRelativeUrl:URL_COUPON parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in responseObject)
            {
                UserCardEntity *entity = [[UserCardEntity alloc]initWithDict:dic];
                if ([entity.c_valida_state integerValue]==1) {
                    [unuseArr addObject:entity];
                }else
                {
                    [expireArr addObject:entity];
                }
                
            }
            self.dataArray = unuseArr;

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
    unuseArr = [NSMutableArray array];
    expireArr = [NSMutableArray array];
}
- (void)configSubviews;
{
    [super configSubviews];
    self.pullView.tableFooterView = [[UIView alloc]init];
//    [self setRightBarButtonItemWithText:@"我的" imageName:nil];
    [self setLeftBarButtonItemWithText:@"我的优惠券" imageName:IMAGENAME_BACK respond:nil];
    ZWHSegmentedControl *segmentedControl = [[ZWHSegmentedControl alloc]initWithSectionTitles:@[@"待使用",@"已过期"]];
    [segmentedControl setSelectionIndicatorMode:HMSelectionIndicatorFillsSegment];
    [segmentedControl setSelectionIndicatorHeight:2];
    [segmentedControl setFrame:CGRectMake(0, 0, SCREENWIDTH, 39)];
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [segmentedControl setTag:1];
    [segmentedControl setTextColor:UIColorFromRGB(0x333333)];
    [segmentedControl setSelectionIndicatorColor:UIColorFromRGB(0x6dcb29)];
    
    [self.view addSubview:segmentedControl];

}
- (void)segmentedControlChangedValue:(ZWHSegmentedControl *)sender {
    
    if (sender.selectedIndex==1) {
        self.dataArray = expireArr;
    }else
    {
        self.dataArray = unuseArr;
    }
    [self.pullView reloadData];
    
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
    return self.dataArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdent = @"cellIdent";
    
    CardListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    
    if (!cell) {
        cell = [[CardListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
        
    }
    UserCardEntity *entity = self.dataArray[indexPath.row];
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.userCard = entity;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
     CardDetailViewController *listVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CardDetailViewController"];
    UserCardEntity *entity = [self.dataArray objectAtIndex:indexPath.row];
    listVC.userCard = entity;
    UIViewController *controller = [[WYPageManager sharedInstance]getCurrentShowViewController];;
    
    [controller.navigationController pushViewController:listVC animated:YES];
    
    
}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 0;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 93;
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
