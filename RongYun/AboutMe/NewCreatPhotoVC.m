//
//  NewCreatPhotoVC.m
//  RongYun
//
//  Created by apple on 15/5/14.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "NewCreatPhotoVC.h"
#import "PhotoSingleton.h"
#import "DoImagePickerController.h"

@interface NewCreatPhotoVC (){
    NSString *name;
    NSString *type;
    
}

@end

@implementation NewCreatPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _upLoadImageArr = [NSMutableArray array];

    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(next)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    _btn1.layer.borderColor = [[UIColor blackColor] CGColor];
    _btn1.layer.borderWidth = 1;
    _btn1.layer.masksToBounds = YES;
    _btn1.layer.cornerRadius = 10;
    
    
    _btn2.layer.borderColor = [[UIColor blackColor] CGColor];
    _btn2.layer.borderWidth = 1;
    _btn2.layer.masksToBounds = YES;
    _btn2.layer.cornerRadius = 10;

    _btn1.tag = 1000;
    [_btn1 setBackgroundImage:[UIImage imageNamed:@"123"] forState:UIControlStateNormal];
    [_btn1 setBackgroundImage:[UIImage imageNamed:@"rc_call_answer_down"] forState:UIControlStateSelected];
    
    _btn2.tag = 1001;
    [_btn2 setBackgroundImage:[UIImage imageNamed:@"123"] forState:UIControlStateNormal];
    [_btn2 setBackgroundImage:[UIImage imageNamed:@"rc_call_answer_down"] forState:UIControlStateSelected];
    
    
}

- (void)next{

    [PhotoSingleton sharedManager].albumName = _textField.text;
     //1为个人  2为共享
    if (_btn1.selected) {
        [PhotoSingleton sharedManager].albumType = @"1";
    }else{
        [PhotoSingleton sharedManager].albumType = @"2";
    }
    
    DoImagePickerController *photoPicker = [[DoImagePickerController alloc] initWithNibName:@"DoImagePickerController" bundle:nil];
    photoPicker.delegate = self;
    photoPicker.nResultType = DO_PICKER_RESULT_UIIMAGE;
    photoPicker.nMaxCount = 9;
    photoPicker.nColumnCount = 3;
    [self.navigationController pushViewController:photoPicker animated:YES];
    
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


- (IBAction)select:(id)sender {
    
    UIButton *btn1 = (UIButton *)[self.view viewWithTag:1000];
    UIButton *btn2 = (UIButton *)[self.view viewWithTag:1001];

    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 1000:{
            name = @"1";
            btn1.selected = YES;
            btn2.selected = NO;
        }
            break;
        case 1001:{
            name = @"2";
            btn1.selected = NO;
            btn2.selected = YES;
        }
            break;
        default:
            break;
    }
    
}
@end
