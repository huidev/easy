//
//  UserBBSDetailVC.m
//  RongYun
//
//  Created by apple on 15/5/21.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "UserBBSDetailVC.h"
#import "BBSDetail_bbsCell.h"
#import "BBSDetail_postCell.h"
#import "PostDetail.h"

@interface UserBBSDetailVC (){

    NSMutableArray *myDataArr;


}

@end

@implementation UserBBSDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    myDataArr = [[NSMutableArray alloc] init];
    self.myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self loadMyData];
}

- (void)loadMyData{
    //查询根据论坛id查找所有主题
    //用户类型  如果为0 普通用户  只查找未禁用的帖子，如果为1 为管理员，查找所有的帖子
    NSDictionary *dic = @{@"otype":@"list",@"f_id":_bbsModel.f_id,@"f_u_type":@"0",@"index":@"1",};
    [self requestGetWithRelativeUrl:URL_POSTOFBBS_LIST parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in responseObject) {
                if ([dic isKindOfClass:[NSDictionary class]]) {
                    PostModel *model= [[PostModel alloc]initWithDict:dic];
                    [myDataArr addObject:model];
                }
            }
            NSLog(@"%@",myDataArr);
            //对 myDataArr 排序置顶的放到前面
            NSMutableArray *tempArr1 = [[NSMutableArray alloc] init];
            NSMutableArray *tempArr2 = [[NSMutableArray alloc] init];
            if (myDataArr.count) {
                for (PostModel *model in myDataArr) {
                    if ([model.t_isdisabled intValue] == 1) {
                        [tempArr1 addObject:model];
                    }else{
                        [tempArr2 addObject:model];
                    }
                }
                
                myDataArr = [[NSMutableArray alloc] init];
                for (int i = 0; i<tempArr2.count; i++) {
                    [tempArr1 addObject:tempArr2[i]];
                }
                
                myDataArr = tempArr1;
                [_myTableView reloadData];

            }
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}

#pragma mark tableview
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 136;
        }else{
            return 15;
        }
    }else{
        return 94;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        PostDetail *postDetail = [[PostDetail alloc] init];
        postDetail.postModel = [myDataArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:postDetail animated:YES];
        
    }
    
    
//    BBSEntity *bbsModel = [bbsDataArray objectAtIndex:indexPath.row];
//    UserBBSDetailVC *post = [[UserBBSDetailVC alloc] init];
//    post.bbsModel = bbsModel;
//    [self.navigationController pushViewController:post animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 2;
    }else{
        return myDataArr.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *identifier1 = @"BBSDetail_bbsCell";
            BBSDetail_bbsCell *bbsCell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier1];
            if (bbsCell == nil) {
                bbsCell = [[NSBundle mainBundle] loadNibNamed:@"BBSDetail_bbsCell" owner:nil options:nil][0];
                bbsCell.selectedBackgroundView = [[UIView alloc] initWithFrame:bbsCell.frame];
                bbsCell.selectedBackgroundView.backgroundColor = cellClickedColor;
            }
            bbsCell.bbsModel = _bbsModel;
            return bbsCell;
        }else{
            static NSString *identifier2 = @"cellID";
            UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier2];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
                cell.userInteractionEnabled = NO;
                cell.contentView.backgroundColor = RGBA(233, 233, 233, 1.0);
            }
            return cell;
        }
        
    }else{
        static NSString *identifier3 = @"BBSDetail_postCell";
        BBSDetail_postCell *postCell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier3];
        if (postCell == nil) {
            postCell = [[NSBundle mainBundle] loadNibNamed:@"BBSDetail_postCell" owner:nil options:nil][0];
            postCell.selectedBackgroundView = [[UIView alloc] initWithFrame:postCell.frame];
            postCell.selectedBackgroundView.backgroundColor = cellClickedColor;
        }
        postCell.postModel = [myDataArr objectAtIndex:indexPath.row];
        return postCell;
    }

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
