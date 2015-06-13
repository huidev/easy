//
//  ContactVC.m
//  RongYun
//
//  Created by apple on 15/5/15.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "ContactVC.h"
#import "PeopleDetailVC.h"

@interface ContactVC ()

@end

@implementation ContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configSubviews];

}
- (void)configSubviews{
    UIBarButtonItem *rigthBar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(barButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = rigthBar;

    _slideSwitchView.topScrollView.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.slideSwitchView.tabItemNormalColor = [LYHSlideSwitchView colorFromHexRGB:@"868686"];
    self.slideSwitchView.tabItemSelectedColor = [LYHSlideSwitchView colorFromHexRGB:@"bb0b15"];
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    
    self.friendVC = [[showContactVC alloc] init];
    self.friendVC.title = @"好友";
    self.friendVC.type = @"0";
    self.friendVC.mydelegate = self;
    
    self.familyVC = [[showContactVC alloc] init];
    self.familyVC.title = @"家庭";
    self.familyVC.type = @"1";
    self.familyVC.mydelegate = self;
    
    self.peopleVC = [[showContactVC alloc] init];
    self.peopleVC.type = @"0";

    self.peopleVC.title = @"新朋友";
    self.peopleVC.mydelegate =self;
    
    UIButton *rightSideButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightSideButton setImage:[UIImage imageNamed:@"icon_rightarrow.png"] forState:UIControlStateNormal];
    [rightSideButton setImage:[UIImage imageNamed:@"icon_rightarrow.png"]  forState:UIControlStateHighlighted];
    rightSideButton.frame = CGRectMake(0, 0, 0.0f, 44.0f);
    rightSideButton.userInteractionEnabled = NO;
    self.slideSwitchView.rigthSideButton = rightSideButton;
    self.slideSwitchView.slideSwitchViewDelegate = self;
    [self.slideSwitchView buildUI];
}

#pragma mark LYHSlideSwitchViewDelegate
- (NSUInteger)numberOfTab:(LYHSlideSwitchView *)view
{
    return 3;
}

- (UIViewController *)slideSwitchView:(LYHSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    if (number == 0) {
        return self.friendVC;
    } else if (number == 1) {
        return self.familyVC;
    } else if (number == 2) {
        return self.peopleVC;
    }else
    {
        return nil;
    }
}

- (void)slideSwitchView:(LYHSlideSwitchView *)view panLeftEdge:(UIPanGestureRecognizer *)panParam
{
    //    SUNViewController *drawerController = (SUNViewController *)self.navigationController.mm_drawerController;
    //    [drawerController panGestureCallback:panParam];
}

- (void)slideSwitchView:(LYHSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    BaseViewController *vc = nil;
    if (number == 0) {
        vc = self.friendVC;
    } else if (number == 1) {
        vc = self.familyVC;
    } else if (number == 2) {
        vc = self.peopleVC;
    }
}
#pragma mark showContactVCDelegate
-(void)pushPeopleDetail{
    
    PeopleDetailVC *peopleDetail = [[PeopleDetailVC alloc] init];
    [self.navigationController pushViewController:peopleDetail animated:YES];
    
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
