//
//  ShowPhotoVC.m
//  RongYun
//
//  Created by apple on 15/5/13.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "ShowPhotoVC.h"
#import "PhotoCell.h"
#import "PhotoListVC.h"
#import "PhotoAlbumModel.h"


@interface ShowPhotoVC (){
    
    NSMutableArray *dataArr;

}
@end

@implementation ShowPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    dataArr = [[NSMutableArray alloc] init];
    self.myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self loadMyData];

}

- (void)loadMyData{
    NSDictionary *dic;
    if ([self.title isEqualToString:@"个人相册"]) {
        dic = @{@"otype":@"list",@"u_id":@"1",@"a_type":@"1",@"index":@"1"};
    }else if ([self.title isEqualToString:@"共享相册"]){
        dic = @{@"otype":@"list",@"u_id":@"1",@"a_type":@"2",@"index":@"1"};
    }else if ([self.title isEqualToString:@"家庭相册"]){
        //f_type = 1  1为亲友   0为好友
        dic = @{@"otype":@"getc",@"u_id":@"1",@"f_type":@"1",@"index":@"1"};

    }
    [self requestGetWithRelativeUrl:URL_PHOTO_LIST parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in responseObject) {
                
                PhotoAlbumModel *model = [[PhotoAlbumModel alloc] initWithDict:dic];
                [dataArr addObject:model];
            }
            [_myTableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //  NSLog(@"%@",error);
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PhotoAlbumModel *model = dataArr[indexPath.row];
    if (_isMe) {
        PhotoListVC *imageList = [[PhotoListVC alloc] init];
        imageList.photoModel = model;
        [self.navigationController pushViewController:imageList animated:YES];
    }else{
        [_myDelegate pushImageList:model];
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 109;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"PhotoCell";
    PhotoCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PhotoCell" owner:nil options:nil][0];
    }
    PhotoAlbumModel *model = dataArr[indexPath.row];
    cell.model = model;
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
