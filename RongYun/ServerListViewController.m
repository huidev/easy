//
//  ServerListViewController.m
//  RongYun
//
//  Created by 乐米科技 on 5/9/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "ServerListViewController.h"
#import "ServerMainViewController.h"
#import "AddServerViewController.h"
#import "ServerListCell.h"
#import "ServerListEntity.h"
static NSString *SERVER_CELL = @"serverCell";

@implementation ServerListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self allocData];
    [self configSubviews];
    if (self.type ==SERVER_RECOMMEND) {
        [self setLeftBarButtonItemWithText:@"推荐服务" imageName:@"service_jt" respond:nil];
        [self.m_tableView reloadData];
    }else if (self.type ==SERVER_NEARBY)
    {
        [self setLeftBarButtonItemWithText:@"附近的服务商" imageName:@"service_jt" respond:nil];
        [self startCoreLocation];
        UserEntity *user = [UserEntity sharedUserEntity];
        
        NSDictionary *param = @{@"otype":@"nearby",@"u_location_x":@(118),@"u_location_y":@(96),@"u_id":user.u_id?user.u_id:@"1",@"index":@(ceilf(self.dataArray.count/20.0))};
        [self requestGetWithRelativeUrl:URL_SERVER_LIST parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([responseObject isKindOfClass:[NSArray class]]) {
                if (self.m_tableView.pullTableIsRefreshing) {
                    [self.dataArray removeAllObjects];
                }else if (self.m_tableView.pullTableIsLoadingMore)
                {
                    
                }
                for (NSDictionary *item in responseObject )
                {
                    if ([item isKindOfClass:[NSDictionary class]]) {
                        ServerListEntity *entity = [[ServerListEntity alloc]initWithDict:item];
                        [self.dataArray addObject:entity];
                    }
                    
                }
                [self.m_tableView reloadData];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
    }else
    {
//        self.type = SERVER_NEARBY;
        [self setLeftBarButtonItemWithText:@"服务" imageName:nil respond:nil];
        [self setRightBarButtonItemWithText:nil imageName:nil];
        UserEntity *user = [UserEntity sharedUserEntity];
        [self requestDataWithParam:@{@"otype":@"list",@"u_id":user.u_id?user.u_id:@"1",@"index":@(ceilf(self.dataArray.count/20.0))}];
    }
    
}

#pragma mark -private method
- (void)startCoreLocation
{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init] ;
    
    if ([CLLocationManager locationServicesEnabled]) {
        
        NSLog( @"Starting CLLocationManager" );
        
        locationManager.delegate = self;
        
        locationManager.distanceFilter = 200;
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        [locationManager startUpdatingLocation];
        
    } else {
        
        NSLog( @"Cannot Starting CLLocationManager" );
    }
}
- (void)requestDataWithParam:(NSDictionary *)param
{
    
//    NSString *url = [[NSString stringWithFormat:@"http://%@/%@",SERVER_HOST,URL_SERVER_LIST] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
//    [self requestPostWithRelativeUrl:URL_SERVER_LIST parameters:@{@"otype":@"list",@"u_id":@"1"} prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//    }];
    if (isRefresh) {
        [self.dataArray removeAllObjects];
    }
    [self requestGetWithRelativeUrl:URL_SERVER_LIST parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            if (self.m_tableView.pullTableIsRefreshing) {
                [self.dataArray removeAllObjects];
            }else if (self.m_tableView.pullTableIsLoadingMore)
            {
                
            }
            for (NSDictionary *item in responseObject )
            {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    ServerListEntity *entity = [[ServerListEntity alloc]initWithDict:item];
                    [self.dataArray addObject:entity];
                }
                
            }
            [self.m_tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)allocData;
{
    [super allocData];
//    self.dataArray = @[@"1",@"2",@"3",@"4",@"5"];
}
- (void)configSubviews;
{
    [super configSubviews];
    self.m_tableView.tableFooterView = [[UIView alloc]init];
    self.m_tableView.pullDelegate = self;
    
    //在storyboard设cell 的identity
//    [self.m_tableView registerNib:[ServerListCell serverListCellNib] forCellReuseIdentifier:SERVER_CELL];
}
- (void)barButtonItemAction:(UIBarButtonItem *)barItem
{
    if (barItem ==self.navigationItem.rightBarButtonItem) {
        AddServerViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddServerViewController"];
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }else
    {
        if(self.type ==SERVER_NEARBY||self.type ==SERVER_RECOMMEND)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
- (void)requestData
{
    UserEntity *user = [UserEntity sharedUserEntity];
    [self requestDataWithParam:@{@"otype":@"list",@"u_id":user.u_id?user.u_id:@"1",@"index":@(ceilf(self.dataArray.count/20.0))}];
}
- (void)tapErrorAction:(UITapGestureRecognizer *)gesture
{
    [self requestData];
//    [self.view sendSubviewToBack:self.errorView];
//    [self.view bringSubviewToFront:self.m_tableView];
}
#pragma network handler
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    if (locations.count) {
        [manager stopUpdatingLocation];
        manager.delegate = nil;
        CLLocation *location = [locations lastObject];
        UserEntity *user = [UserEntity sharedUserEntity];
        
        NSDictionary *param = @{@"otype":@"nearby",@"u_location_x":@(location.horizontalAccuracy),@"u_location_y":@(location.altitude),@"u_id":user.u_id?user.u_id:@"1",@"index":@(ceilf(self.dataArray.count/20.0))};
        [self requestDataWithParam:param];
    }
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
    ServerListCell *cell = [tableView dequeueReusableCellWithIdentifier:SERVER_CELL];
    if (!cell) {
        cell = [[ServerListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SERVER_CELL];
        
    }
    ServerListEntity *entity = self.dataArray[indexPath.row];
    cell.model = entity;
    if (self.type==SERVER_NEARBY) {
        cell.briefLB.tintColor = COLOR_REDWINE;
        [cell.briefLB setImage:[UIImage imageNamed:@"service_ima"] forState:UIControlStateNormal];
        [cell.briefLB setTitle:[NSString stringWithFormat:@"%@",entity.s_distance] forState:UIControlStateNormal];
    }else
    {
        [cell.briefLB setImage:nil forState:UIControlStateNormal];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.type == SERVER_NEARBY) {
        HomeViewController *homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        homeVC.attendionServerBlock = ^(ServerListEntity *item){
            [self.dataArray removeObjectAtIndex:indexPath.row];
            [self.m_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        ServerListEntity *entity = [self.dataArray objectAtIndex:indexPath.row];
        homeVC.s_id = entity.s_id;
        homeVC.isAttented = NO;
        [self.navigationController pushViewController:homeVC animated:YES];
    }else
    {
        ServerMainViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ServerMainViewController"];
        vc.cancelAttentionBlock = ^(NSString *sid)
        {
            int index = 0;
            for (int i=0; i<self.dataArray.count; i++) {
                ServerListEntity *item = self.dataArray[i];
                if ([item.s_id intValue]==[sid intValue]) {
                    index = i;
                    [self.dataArray removeObject:item];
                    break;
                }
            }
            [self.m_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
            
        };
        ServerListEntity *entity = self.dataArray[indexPath.row];
        vc.s_id = entity.s_id;
        vc.currentServer = entity;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];

    }
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
#pragma mark -uitableView delegate

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//    if ([segue.identifier isEqualToString:@"promotionProtocol"]) {
//        
//    }
}

@end
