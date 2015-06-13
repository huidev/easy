//
//  BBSViewController.m
//  RongYun
//
//  Created by 乐米科技 on 5/9/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BBSViewController.h"
#import "BBSListCell.h"
#import "BBSEntity.h"
#import "BBSDetailVC.h"
#import "CreatBBSVC.h"

static NSString *CELLIdentifcation = @"BBSListCell";
@implementation BBSViewController

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
    [self setLeftBarButtonItemWithText:@"论坛" imageName:nil respond:nil];
    [self setRightBarButtonItemWithText:nil imageName:nil];
    [self allocData];
    [self configSubviews];
    [self loadMyData];
}

- (void)barButtonItemAction:(UIBarButtonItem *)barItem
{
    
    CreatBBSVC *creat = [[CreatBBSVC alloc] init];
    creat.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:creat animated:YES];
    
//    if (barItem ==self.navigationItem.rightBarButtonItem) {
//        UITableViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"searchListViewController"];
//        [self.navigationController pushViewController:viewController animated:YES];
//    }
}

#pragma mark -private method

- (void)loadMyData{
    NSDictionary *dic = @{@"otype":@"list",@"u_id":@"1"};
    [self requestGetWithRelativeUrl:URL_MYBBS_LIST parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in responseObject) {
                if ([dic isKindOfClass:[NSDictionary class]]) {
                    BBSEntity *model= [[BBSEntity alloc]initWithDict:dic];
                    [self.dataArray addObject:model];
                }
            }
            [_m_tableView reloadData];
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)allocData;
{
    [super allocData];
}
- (void)configSubviews;
{
    [super configSubviews];
    //    [self.m_tableView registerNib:[ServerListCell serverListCellNib] forCellReuseIdentifier:SERVER_CELL];
}
- (void)tapErrorAction:(UITapGestureRecognizer *)gesture
{
    [self.view sendSubviewToBack:self.errorView];
    [self.view bringSubviewToFront:self.m_tableView];
}
#pragma network handler

#pragma mark - uitableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.dataArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    BBSListCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLIdentifcation];
    if (!cell) {
        cell = [[BBSListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLIdentifcation];
        
    }
    BBSEntity *entity = [[BBSEntity alloc] init];
    entity = self.dataArray[indexPath.row];
    cell.bbsModel = entity;
    return cell;
}
#pragma mark -uitableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BBSEntity *bbsModel = [self.dataArray objectAtIndex:indexPath.row];
    BBSDetailVC *post = [[BBSDetailVC alloc] init];
    post.bbsModel = bbsModel;
    post.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:post animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
