//
//  MyPostVC.m
//  RongYun
//
//  Created by apple on 15/5/16.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "MyPostVC.h"
#import "PostListCell.h"
#import "PostDetail.h"
@interface MyPostVC (){

    NSMutableArray *postDataArr;

}

@end

@implementation MyPostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    postDataArr = [[NSMutableArray alloc] init];
    _myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self loadMyData];
    
}

- (void)loadMyData{
    
    NSDictionary *dic = @{@"otype":@"gett",@"u_id":@"1",@"f_u_type":@"0",@"index":@"1",};
    self.httpRequest = [WHHttpClient defaultClient];
    [self.httpRequest requestWithPath:URL_USER_LIST method:RTHttpRequestGet parameters:dic  prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in responseObject) {
                if ([dic isKindOfClass:[NSDictionary class]]) {
                    PostModel *model= [[PostModel alloc]initWithDict:dic];
                    [postDataArr addObject:model];
                }
            }
            [_myTableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);

    }];
    
    
//    2015-05-22 01:27:22.816 RongYun[5376:119943] -[__NSCFArray objectForKey:]: unrecognized selector sent to instance 0x7ff120def940
//    2015-05-22 01:27:22.830 RongYun[5376:119943] *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[__NSCFArray objectForKey:]: unrecognized selector sent to instance 0x7ff120def940'
//     NSDictionary *dic = @{@"otype":@"list",@"f_id":_bbsModel.f_id,@"f_u_type":@"0",@"index":@"1",};
//    [self requestGetWithRelativeUrl:URL_POSTOFBBS_LIST parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@",responseObject);
//        
//        if ([responseObject isKindOfClass:[NSArray class]]) {
//            for (NSDictionary *dic in responseObject) {
//                if ([dic isKindOfClass:[NSDictionary class]]) {
//                    BBSEntity *model= [[BBSEntity alloc]initWithDict:dic];
//                    [postDataArr addObject:model];
//                }
//            }
//            [_myTableView reloadData];
//        }
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@",error);
//    }];
    
}


#pragma mark tableView
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PostDetail *post = [[PostDetail alloc] init];
    post.postModel = postDataArr[indexPath.row];
    [self.navigationController pushViewController:post animated:YES];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return postDataArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"PostListCell";
    PostListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PostListCell" owner:nil options:nil][0];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = cellClickedColor;
    }
    
    if (postDataArr.count) {
        cell.postModel = (PostModel *)[postDataArr objectAtIndex:indexPath.row];

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
