//
//  BaseTableViewController.m
//  RongYun
//
//  Created by 乐米科技 on 5/9/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseTableViewController.h"

@implementation BaseTableViewController
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
}
#pragma mark -private method
- (void)allocData;
{
    self.dataArray = [NSMutableArray array];
}
- (void)configSubviews;
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
