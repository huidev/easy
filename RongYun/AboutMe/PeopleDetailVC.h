//
//  PeopleDetailVCViewController.h
//  RongYun
//
//  Created by apple on 15/5/16.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeopleDetailVC : UIViewController<UITableViewDataSource,UITableViewDelegate>{

    NSArray *_nameArr;
    NSMutableArray *_subNameArr;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *bgImageV;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
- (IBAction)editName:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
- (IBAction)deledeFriend:(id)sender;

@end
