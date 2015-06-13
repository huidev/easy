//
//  PeopleDetailVCViewController.m
//  RongYun
//
//  Created by apple on 15/5/16.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "PeopleDetailVC.h"
#import "SetCell.h"
#import "RemarkNameVC.h"
#import "ShowPhotoVC.h"
#import "MyPostVC.h"
#import "UserBBSListVC.h"
@interface PeopleDetailVC ()

@end

@implementation PeopleDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _subNameArr = [[NSMutableArray alloc] init];
    _nameArr =@[@[@"账号信息",@"个性签名"],@[@"我的帖子",@"我的论坛",@"我的相册"]];
    
    self.view.backgroundColor = BGColor;
    _myTableView.backgroundColor = [UIColor clearColor];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark tableview delegate
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_WIDTH, 20)];
    v.backgroundColor = [UIColor clearColor];
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

#pragma mark - uitableView datesource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section == 1 ) {
        return 3;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"SetCellID";
    SetCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = (SetCell *)[[NSBundle mainBundle] loadNibNamed:@"SetCell" owner:nil options:nil][0];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = cellClickedColor;
        cell.contentLab.hidden = NO;
        cell.contentLab.text = @"";
    }
    cell.lab1.hidden = YES;
    cell.lab2.hidden = YES;
    
    if (indexPath.section == 0) {
        cell.imageV.hidden = YES;
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.subNameLab.hidden = NO;
    }
    
    cell.nameLab.text = _nameArr[indexPath.section][indexPath.row];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:{
                MyPostVC *post = [[MyPostVC alloc] init];
                [self.navigationController pushViewController:post animated:YES];
            }
                break;
            case 1:{
                UserBBSListVC *bbs = [[UserBBSListVC alloc] init];
                [self.navigationController pushViewController:bbs animated:YES];
            }
                break;
            case 2:{
                ShowPhotoVC *photo = [[ShowPhotoVC alloc] init];
                photo.isMe = YES;
                [self.navigationController pushViewController:photo animated:YES];
                break;
                
            }
            default:
                break;
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

- (IBAction)editName:(id)sender {
    
    RemarkNameVC *remarkVC = [[RemarkNameVC alloc] init];
    [self.navigationController pushViewController:remarkVC animated:YES];
}
- (IBAction)deledeFriend:(id)sender {
}
@end
