//
//  CardDetailViewController.m
//  RongYun
//
//  Created by 乐米科技 on 5/19/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "CardDetailViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
@interface CardDetailViewController ()

@end

@implementation CardDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBarButtonItemWithText:@"详情" imageName:IMAGENAME_BACK respond:nil];
    // Do any additional setup after loading the view.
}
- (void)barButtonItemAction:(UIBarButtonItem *)barItem
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)showDimensionCodeGesture:(UIGestureRecognizer *)gesture
{
    UIImageView *targetView = (UIImageView *)gesture.view;
    
    if (targetView.tag ==100) {
        [targetView setImageWithURL:[NSURL URLWithString:self.userCard.u_tow_dimension_img] placeholderImage:IMAGE_HOLD];
        targetView.tag = 11;
    }else
    {
        [targetView setImageWithURL:[NSURL URLWithString:self.userCard.c_ico] placeholderImage:IMAGE_HOLD];
        targetView.tag = 100;

    }
    
}
#pragma mark - uitableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section==0) {
        return 1;
    }else if (section==1)
        return 3;
    else if (section ==2)
        return 1;
    else
        return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 3;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdent = @"permissionCell";
    static NSString *cardCell = @"cellCard";
    static NSString *useCell = @"useCell";
    UITableViewCell *cell;
    if (indexPath.section==0) {
        cell= [tableView dequeueReusableCellWithIdentifier:cardCell];
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
        
        if (self.userCard) {
            [imageView setImageWithURL:[NSURL URLWithString:self.userCard.c_ico] placeholderImage:IMAGE_HOLD];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDimensionCodeGesture:)];
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:tap];
        }else
        {
            [imageView setImageWithURL:[NSURL URLWithString:self.cardEntity.c_ico] placeholderImage:IMAGE_HOLD];
        }
    }else if (indexPath.section==1)
    {
        cell= [tableView dequeueReusableCellWithIdentifier:cellIdent];
         UIImageView *imageV = (UIImageView *)[cell.contentView viewWithTag:10];
        UILabel *valueLB = (UILabel *)[cell.contentView viewWithTag:11];
        if (indexPath.row==0) {
            imageV.image = [UIImage imageNamed:@"s_c_d1"];
            if (self.userCard) {
                valueLB.text = [NSString stringWithFormat:@"本优惠券共领取%@张，已使用%@张",self.userCard.c_count,self.userCard.c_used_count];
            }else
            {
                valueLB.text = [NSString stringWithFormat:@"本优惠券剩余%@张",self.cardEntity.c_remain];
            }
            
        }else if (indexPath.row==1)
        {
            imageV.image = [UIImage imageNamed:@"s_c_d2"];
            if(self.userCard)
            {
                valueLB.text = [NSString stringWithFormat:@"领取时间：%@",self.userCard.c_get_date];
            }else
            {
                valueLB.text = [NSString stringWithFormat:@"拥有%@者方可领取",self.cardEntity.c_condition];
            }
            
        }else if (indexPath.row==2)
        {
            imageV.image = [UIImage imageNamed:@"s_c_d3"];
            if (self.userCard) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[self.userCard.c_info dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                CardListEntity *cardInfo = [[CardListEntity alloc]initWithDict:dic];
                valueLB.text = [NSString stringWithFormat:@"有效时间：%@",cardInfo.c_validity_date_end];
            }else
            {
                valueLB.text = [NSString stringWithFormat:@"活动时间：%@至%@",self.cardEntity.c_validity_date_begin,self.cardEntity.c_validity_date_end];
            }
            
        }
    }else if (indexPath.section ==2)
    {
        cell= [tableView dequeueReusableCellWithIdentifier:useCell];
        UILabel *valueLB = (UILabel *)[cell.contentView viewWithTag:10];
        if (self.cardEntity) {
            valueLB.text = self.cardEntity.c_desc;
        }else
        {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[self.userCard.c_info dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            CardListEntity *cardInfo = [[CardListEntity alloc]initWithDict:dic];
            valueLB.text = cardInfo.c_desc;
        }
        
    }
    
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.cardEntity = entity;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // ServerListViewController *listVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ServerListViewController"];
    
    UIViewController *controller = [[WYPageManager sharedInstance]getCurrentShowViewController];;
    
    [controller.navigationController pushViewController:nil animated:YES];
    
    
}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 0;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            return 120;
        }
            break;
        case 1:
        {
            return 30;
        }
            break;
        case 2:
        {
            
        }
            break;
        default:
            break;
    }
    return 93;
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
