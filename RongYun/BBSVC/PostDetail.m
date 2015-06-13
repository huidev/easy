//
//  postDetail.m
//  RongYun
//
//  Created by apple on 15/5/16.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "PostDetail.h"
#import "PostDetailCell.h"
#import "ReplyVC.h"
#import "PostReplyModel.h"
@interface PostDetail (){


    NSMutableArray *myDataArr;
    
}

@end

@implementation PostDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    myDataArr = [[NSMutableArray alloc] init];
    
    _btn1.layer.masksToBounds = YES;
    _btn1.layer.cornerRadius = 8;
    _btn1.layer.borderColor = [LineColor CGColor];
    _btn2.layer.borderWidth = 1;
    
    _myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self loadMydata];
}

- (void)loadMydata{
    //f_id 论坛    t_id
    NSDictionary *dic = @{@"otype":@"list",@"t_id":@"1",@"f_id":_postModel.t_f_id,@"index":@"1",};
    [self requestGetWithRelativeUrl:URL_POSTREPLY_LIST parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in responseObject) {
                if ([dic isKindOfClass:[NSDictionary class]]) {
                    PostReplyModel *model= [[PostReplyModel alloc]initWithDict:dic];
                    [myDataArr addObject:model];
                }
            }
            [_myTableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

#pragma mark tableView
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
       return  [PostDetailCell cellHeight1:_postModel];
    }else{
        return [PostDetailCell  cellHeight2:[myDataArr objectAtIndex:indexPath.row-1]];
    }

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return myDataArr.count+1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"PostDetailCell";
    PostDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PostDetailCell" owner:nil options:nil][0];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = cellClickedColor;
    }
    if (indexPath.row != 0) {
        cell.titleLab.text = @"";
        cell.landlordLab.hidden = YES;
        cell.reportBtn.hidden = YES;
        cell.signatureLab.hidden = YES;
        if (myDataArr.count) {
            PostReplyModel *model = myDataArr[indexPath.row-1];
            cell.model = model;
        }

    }else{
        cell.titleLab.text = @"帖子标题";
        cell.landlordLab.hidden = NO;
        cell.reportBtn.hidden = NO;
        cell.signatureLab.hidden = NO;
        
        
        cell.postModel = _postModel;

    }
    cell.landLab.text = [NSString stringWithFormat:@"%ld楼",(long)indexPath.row+ 1];

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

- (IBAction)reply:(id)sender {
    
    ReplyVC *reply = [[ReplyVC alloc] init];
    [self.navigationController pushViewController:reply animated:YES];
}
@end
