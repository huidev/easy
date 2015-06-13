//
//  AboutMeViewController.m
//  RongYun
//
//  Created by 乐米科技 on 5/9/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "AboutMeViewController.h"
#import "AboutMeCell2.h"
#import "AboutMeInfoCell.h"
#import "MyInfoVC.h"
#import "NoticeVC.h"
#import "MyPhotoVC.h"
#import "ContactVC.h"
#import "MyPostVC.h"
#import "UserBBSListVC.h"
static NSString *ABOUT_CELL = @"AboutMeCell2";
static NSString *ABOUTBTN_CELL = @"AboutMeBtnCell";
static NSString *ABOUTINFO_CELL = @"AboutMeInfoCell";

@implementation AboutMeViewController


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
//    [self requestData];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    _my_tableView.backgroundColor = [UIColor clearColor];
    //_my_tableView.refreshType = PRPullDownRefresh;
    //self.automaticallyAdjustsScrollViewInsets = NO;
    _my_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)allocData;
{
    [super allocData];
    imageArr = [[NSMutableArray alloc] initWithObjects:@[@"pres_ima_2",@"pres_ima_3"],@[@"pres_ima_4",@"pres_ima_5",@"pres_ima_7"], nil];
    nameArr = [[NSMutableArray alloc] initWithObjects:@[@"我的帖子",@"我的论坛"],@[@"通知",@"设置",@"退出"], nil];

}

- (void)configSubviews{
    [self setLeftBarButtonItemWithText:@"个人中心" imageName:nil respond:nil];
//    self.title = @"";
//    
//    UIButton *titleBT = [UIButton buttonWithType:UIButtonTypeCustom];
//    [titleBT setTitle:@"个人中心" forState:UIControlStateNormal];
//    titleBT.titleLabel.font = [UIFont systemFontOfSize:14];
//    [titleBT setImage:[UIImage imageNamed:@"ima_nodate"] forState:UIControlStateNormal];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:titleBT];
//    self.navigationItem.leftBarButtonItem = leftItem;
//    self.view.backgroundColor = BGColor;
}

- (void)barButtonItemAction:(UIBarButtonItem *)barItem
{
    
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
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 100;
        }else{
            return 44;
        }
    }else{
        return 44;
    }
    
}

#pragma mark - uitableView datesource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section == 2 ) {
        return 3;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            AboutMeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ABOUTINFO_CELL];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"AboutMeInfoCell" owner:nil options:nil][0];
            }

            return cell;
        }else{
            AboutMeBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:ABOUTBTN_CELL];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"AboutMeBtnCell" owner:nil options:nil][0];
            }
            cell.mydelegate = self;
            return cell;
        }
    }else{
        AboutMeCell2 *cell = [tableView dequeueReusableCellWithIdentifier:ABOUT_CELL];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"AboutMeCell2" owner:nil options:nil][0];
        }
        cell.imageV.image = [UIImage imageNamed:imageArr[indexPath.section-1][indexPath.row]];
        cell.nameLab.text = nameArr[indexPath.section-1][indexPath.row];
        
        if (indexPath.row == 0) {
            UIView *v1 = cell.lineView1;
            [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[v1]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(v1)]];
            
            UIView *v2 = cell.lineView2;
            [cell.contentView  addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-12-[v2]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(v2)]];
        }else if ((indexPath.section == 1 && indexPath.row == 1) || indexPath.row == 2){
            cell.lineView1.hidden = YES;
            
            UIView *v2 = cell.lineView2;
            [cell.contentView  addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[v2]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(v2)]];
        }else{
            cell.lineView1.hidden = YES;
            
            UIView *v2 = cell.lineView2;
            [cell.contentView  addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-12-[v2]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(v2)]];
        }
        return cell;
        
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1:
            switch (indexPath.row) {
                case 0:{
                    MyPostVC *mypost = [[MyPostVC alloc] init];
                    mypost.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:mypost animated:YES];
                }
                    break;
                case 1:{
                    UserBBSListVC *bbs = [[UserBBSListVC alloc] init];
                    bbs.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:bbs animated:YES];
                }
                    break;
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:{
                    NoticeVC *notice = [[NoticeVC alloc] init];
                    notice.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:notice animated:YES];
                }
                    break;
                case 1:
                    
                    break;
                case 2:{

                }
                    break;
                default:
                    break;
            }
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark AboutMeBtnCellDelegate
-(void)pushMyInfo{
    MyInfoVC *info = [[MyInfoVC alloc] init];
    info.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:info animated:YES];
}
-(void)pushMyPhoto{
    MyPhotoVC *photo = [[MyPhotoVC alloc] init];
    photo.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:photo animated:YES];
}
- (void)pushMyContact{
    ContactVC *photo = [[ContactVC alloc] init];
    photo.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:photo animated:YES];
}
@end
