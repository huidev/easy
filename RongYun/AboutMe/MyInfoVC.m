//
//  MyInfoVC.m
//  RongYun
//
//  Created by apple on 15/5/12.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "MyInfoVC.h"
#import "SetCell.h"
#import "UIImageView+WebCache.h"
#import "UserInfoModel.h"
#import "UserInfoSingleton.h"

@interface MyInfoVC (){

    NSArray *listArr;
    UserInfoModel *model;
}

@end

@implementation MyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    listArr = @[@[@"头像",@"姓名",@"性别",@"我的二维码"],@[@"地区",@"电子邮箱",@"职业",@"单位",@"生日",@"签名"]];
    self.view.backgroundColor = BGColor;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BGColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self loadMyData];
}

-(void)loadMyData{

    NSDictionary *dic = @{@"otype":@"getuser",@"u_id":@"1"};
    [self requestGetWithRelativeUrl:URL_USER_LIST parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            model = [[UserInfoModel alloc] initWithDict:responseObject];
            
            [UserInfoSingleton sharedManager].u_id = @"1";
            [UserInfoSingleton sharedManager].u_name =model.u_name;
            [UserInfoSingleton sharedManager].u_ico = model.u_ico;

            [_tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

#pragma mark tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_WIDTH, 20)];
    v.backgroundColor = [UIColor clearColor];
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 65;
    }else{
        return 40;
    }
}

#pragma mark datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else{
        return 6;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"SetCellID";
    SetCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = (SetCell *)[[NSBundle mainBundle] loadNibNamed:@"SetCell" owner:nil options:nil][0];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = cellClickedColor;
        cell.contentLab.hidden = NO;
        cell.contentLab.text = @"";
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UIView *v1 = cell.lab1;
            cell.lab1.hidden = NO;
            [cell.contentView  addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[v1]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(v1)]];
            
            UIView *v2 = cell.lab2;
            cell.lab2.hidden = NO;
            [cell.contentView  addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-12-[v2]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(v2)]];
            UIImageView *porImageV = [[UIImageView alloc] init];
            porImageV.layer.masksToBounds = YES;
            porImageV.layer.cornerRadius = 22.5;
            porImageV.frame = CGRectMake(MY_WIDTH-32-45, 10, 45, 45);
            [porImageV sd_setImageWithURL:[NSURL URLWithString:model.u_ico] placeholderImage:[UIImage imageNamed:@"b_ima_t_people"]];
            [cell.contentView addSubview:porImageV];
        }else if(indexPath.row == 3){
            cell.lab1.hidden = YES;
            
            UIView *v2 = cell.lab2;
            cell.lab2.hidden = NO;
            [cell.contentView  addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[v2]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(v2)]];
            
            UIImageView *porImageV = [[UIImageView alloc] init];
            porImageV.frame = CGRectMake(MY_WIDTH-32-30, 5, 30, 30);
            [porImageV sd_setImageWithURL:[NSURL URLWithString:model.u_tow_dimension_img] placeholderImage:[UIImage imageNamed:@"b_ima_t_people"]];
            [cell.contentView addSubview:porImageV];
        }else{
            cell.lab1.hidden = YES;
            
            UIView *v2 = cell.lab2;
            cell.lab2.hidden = NO;
            [cell.contentView  addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-12-[v2]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(v2)]];
        }
        
        
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UIView *v1 = cell.lab1;
            cell.lab1.hidden = NO;
            [cell.contentView  addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[v1]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(v1)]];
            
            UIView *v2 = cell.lab2;
            cell.lab2.hidden = NO;
            [cell.contentView  addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-12-[v2]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(v2)]];
        }else if (indexPath.row == 6){
            cell.lab1.hidden = YES;
            
            UIView *v2 = cell.lab2;
            cell.lab2.hidden = NO;
            [cell.contentView  addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[v2]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(v2)]];
        }else{
            cell.lab1.hidden = YES;
            
            UIView *v2 = cell.lab2;
            cell.lab2.hidden = NO;
            [cell.contentView  addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-12-[v2]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(v2)]];
        }

    }
    
    cell.nameLab.text = listArr[indexPath.section][indexPath.row];

    if (model.u_name.length) {
        switch (indexPath.section) {
            case 0:
                switch (indexPath.row) {
                    case 0:
                        
                        break;
                    case 1:
                        cell.contentLab.text = model.u_name;
                        break;
                    case 2:
                        cell.contentLab.text = model.u_sex;
                        break;
                    case 3:
                        
                        break;
                        
                    default:
                        break;
                }
                break;
            case 1:
                switch (indexPath.row) {
                    case 0:
                        cell.contentLab.text = model.u_city;
                        break;
                    case 1:
                        cell.contentLab.text = model.u_email;
                        break;
                    case 2:
                        cell.contentLab.text = model.u_profession;
                        break;
                    case 3:
                        cell.contentLab.text = model.u_company;
                        break;
                    case 4:
                        cell.contentLab.text = model.u_b_date;
                        break;
                    case 5:
                        cell.contentLab.text = model.u_endorse;
                        break;
                    default:
                        break;
                }
                break;
                
            default:
                break;
        }

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
