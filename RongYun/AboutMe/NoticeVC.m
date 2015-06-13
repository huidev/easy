//
//  NoticeVC.m
//  RongYun
//
//  Created by apple on 15/5/13.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "NoticeVC.h"
#import "NoticeCell.h"
@interface NoticeVC (){
    NSArray *listArr;
}

@end

@implementation NoticeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    listArr = @[@"pers_notice_ima",@"pers_notice_ima_post",@"pers_notice_ima_forum",@"pers_notice_ima_mes"];
    
    self.view.backgroundColor = BGColor;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BGColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
#pragma mark tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

#pragma mark datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"noticeCell";
    NoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NoticeCell" owner:nil options:nil][0];
    }
    
    cell.imageV.image = [UIImage imageNamed:listArr[indexPath.row]];
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
