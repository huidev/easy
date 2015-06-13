//
//  showContactVC.m
//  RongYun
//
//  Created by apple on 15/5/15.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "showContactVC.h"
#import "ContactCell.h"
@interface showContactVC ()

@end

@implementation showContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self loadMyData];
}

- (void)loadMyData{

    NSDictionary *dic = @{@"otype":@"getc",@"u_id":@"1",@"f_type":_type};
    [self requestGetWithRelativeUrl:URL_USER_LIST parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
          //  model = [[UserInfoModel alloc] initWithDict:responseObject];
            [_myTableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    [_mydelegate pushPeopleDetail];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 109;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"ContactCell";
    ContactCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ContactCell" owner:nil options:nil][0];
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
