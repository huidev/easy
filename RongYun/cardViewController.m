//
//  cardViewController.m
//  RongYun
//
//  Created by 乐米科技 on 5/17/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "cardViewController.h"
#import "CardListCell.h"
#import "CardDetailViewController.h"
#import "MyCardViewController.h"
@interface cardViewController ()
{
    BOOL isRefresh;
}
//@property (weak, nonatomic)IBOutlet 
@end

@implementation cardViewController

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
    NSDictionary *param = @{@"otype":@"getc",@"s_id":self.s_id?self.s_id:@"1",@"u_id":(user.u_id?user.u_id:@"1")};
    
    [self requestGetWithRelativeUrl:URL_SERVER_LIST parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in responseObject)
            {
                CardListEntity *entity = [[CardListEntity alloc]initWithDict:dic];
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

        MyCardViewController *cardVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyCardViewController"];
        cardVC.s_id = self.s_id;
        [self.navigationController pushViewController:cardVC animated:YES];
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
    CardListEntity *entity = self.dataArray[indexPath.row];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.cardEntity = entity;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    CardDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CardDetailViewController"];
    detailVC.cardEntity = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
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
