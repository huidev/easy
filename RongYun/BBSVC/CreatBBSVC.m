//
//  CreatBBSVC.m
//  RongYun
//
//  Created by apple on 15/6/4.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "CreatBBSVC.h"
#import "UpLoadPortrait.h"

@interface CreatBBSVC ()

@end

@implementation CreatBBSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setRightBarButtonItemWithText:@"下一步" imageName:nil];
    
    self.errorView.hidden = YES;
    self.view.backgroundColor = BGColor;
    
    self.titleTV.tag = 50;
    self.titleTV.text = @"论坛简介";
    self.titleTV.textColor = [UIColor lightGrayColor];

    self.conTextView.tag = 51;
    self.conTextView.text = @"请输入论坛名字，不能超过10个字";
    self.conTextView.textColor = [UIColor lightGrayColor];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewChanged:) name:UITextViewTextDidChangeNotification object:self.conTextView];

}


- (void)barButtonItemAction:(UIBarButtonItem *)barItem{

    UpLoadPortrait *up = [[UpLoadPortrait alloc] init];
    [self.navigationController pushViewController:up animated:YES];
    
}




- (void)textViewChanged:(NSNotification *)notif
{
    //    NSString *textStr = [[notif object] text];
    
    

}
- (void)textViewDidBeginEditing:(UITextView *)textView;
{
    
}
- (void)textViewDidEndEditing:(UITextView *)textView;
{
    if ([textView.text isEqualToString:@""]) {
        if (textView.tag == 50) {
            textView.text = @"论坛简介";
            textView.textColor = [UIColor lightGrayColor];
        }else{
            textView.text = @"请输入论坛名字，不能超过10个字";
            textView.textColor = [UIColor lightGrayColor];
        }

    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{
    
    if (textView.tag == 50) {
        if ([textView.text isEqualToString:@"论坛简介"]&&[text isEqualToString:@""]) {
            textView.text = text;
            textView.selectedRange=NSMakeRange(0,0);
            textView.textColor = [UIColor blackColor];
        }else if ([textView.text isEqualToString:@"论坛简介"]&&![text isEqualToString:@""])
        {
            textView.text = text;
            textView.selectedRange=NSMakeRange(1,0);
            textView.textColor = [UIColor blackColor];
            return NO;
        }
    }else{
        if ([textView.text isEqualToString:@"请输入论坛名字，不能超过10个字"]&&[text isEqualToString:@""]) {
            textView.text = text;
            textView.selectedRange=NSMakeRange(0,0);
            textView.textColor = [UIColor blackColor];
        }else if ([textView.text isEqualToString:@"请输入论坛名字，不能超过10个字"]&&![text isEqualToString:@""])
        {
            textView.text = text;
            textView.selectedRange=NSMakeRange(1,0);
            textView.textColor = [UIColor blackColor];
            return NO;
        }
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView;
{
    
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
