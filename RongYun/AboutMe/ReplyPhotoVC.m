//
//  ReplyPhotoVC.m
//  RongYun
//
//  Created by apple on 15/6/9.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "ReplyPhotoVC.h"
#import "replyCell.h"
#import "ReplyVC.h"
@interface ReplyPhotoVC ()

@end

@implementation ReplyPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadMyData];
}

- (void)loadMyData{

    NSDictionary *dic = @{@"otype":@"pclist",@"p_id":_model.p_id,@"a_id":_model.a_id,@"index":@"1",};
    [self requestGetWithRelativeUrl:URL_PHOTO_LIST parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        
//        if ([responseObject isKindOfClass:[NSArray class]]) {
//            for (NSDictionary *dic in responseObject) {
//                if ([dic isKindOfClass:[NSDictionary class]]) {
//                    PostReplyModel *model= [[PostReplyModel alloc]initWithDict:dic];
//                    [myDataArr addObject:model];
//                }
//            }
//            [_myTableView reloadData];
//        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];

}

#pragma mark tableView
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 70;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count+1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"replyCell";
    replyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"replyCell" owner:nil options:nil][0];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = cellClickedColor;
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

- (IBAction)praise:(id)sender {
}
- (IBAction)reply:(id)sender {
    
    ReplyVC *reply = [[ReplyVC alloc] init];
    reply.replyType = ReplyPhoto;
    [self.navigationController pushViewController:reply animated:YES];
    
}
@end
