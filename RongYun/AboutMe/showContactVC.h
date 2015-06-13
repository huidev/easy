//
//  showContactVC.h
//  RongYun
//
//  Created by apple on 15/5/15.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "ViewController.h"
#import "showContactVC.h"
#import "BaseViewController.h"
@protocol showContactVCDelegate <NSObject>

- (void)pushPeopleDetail;

@end


@interface showContactVC : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,copy)NSString *type;//0好友  1亲友／家庭
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic,strong) showContactVC *friendContact;
@property (nonatomic,strong) showContactVC *familyContact;

@property (weak,nonatomic) id<showContactVCDelegate>mydelegate;

@end
