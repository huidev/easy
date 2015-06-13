//
//  MyBBSVC.m
//  RongYun
//
//  Created by apple on 15/5/18.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "UserBBSListVC.h"
#import "BBSCell.h"
#import "UserBBSDetailVC.h"
#import "UserBBSModel.h"

@interface UserBBSListVC (){

    NSMutableArray *bbsDataArray;
}

@end

@implementation UserBBSListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    bbsDataArray = [[NSMutableArray alloc] init];
    _myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
   [self loadMyData];
    
}


- (void)loadMyData{
    
    
    //接口文档：(1)用户论坛
    NSDictionary *dic = @{@"otype":@"getf",@"u_id":@"1"};
    self.httpRequest = [WHHttpClient defaultClient];

    [self requestGetWithRelativeUrl:URL_USER_LIST parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in responseObject) {
                if ([dic isKindOfClass:[NSDictionary class]]) {
                    UserBBSModel *model= [[UserBBSModel alloc]initWithDict:dic];
                    [bbsDataArray addObject:model];
                }
            }
            [_myTableView reloadData];
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

    
}

#pragma mark tableview
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserBBSModel *bbsModel = [bbsDataArray objectAtIndex:indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UserBBSDetailVC *post = [[UserBBSDetailVC alloc] init];
    post.bbsModel = bbsModel;
    [self.navigationController pushViewController:post animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return bbsDataArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *identifier = @"BBSCell";
    BBSCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BBSCell" owner:nil options:nil][0];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = cellClickedColor;
    }
    if (bbsDataArray.count) {
        UserBBSModel *bbsModel = [bbsDataArray objectAtIndex:indexPath.row];
        cell.bbsModel = bbsModel;
    }

    return cell;
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
