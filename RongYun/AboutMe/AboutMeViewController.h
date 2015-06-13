//
//  AboutMeViewController.h
//  RongYun
//
//  Created by 乐米科技 on 5/9/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseViewController.h"
#import "AboutMeBtnCell.h"

@interface AboutMeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,AboutMeBtnCellDelegate>{

    NSMutableArray *imageArr;
    NSMutableArray *nameArr;
}
@property (weak, nonatomic) IBOutlet PullTableView *my_tableView;

@end
