//
//  photoDetailVC.m
//  RongYun
//
//  Created by apple on 15/6/8.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "PhotoDetailVC.h"
#import "ReplyPhotoVC.h"
#import "PhotoModel.h"
@interface PhotoDetailVC (){

    NSInteger pageNum;
}

@end

@implementation PhotoDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//
//    [_photoScrollView setPhotosWithPhotoDicArr:_imageS photoUrls:_urlArray currentIndex:(int)_indexNum currentFrame:CGRectMake(0, 0, 100, 100)];
//   _photoScrollView = [_photoScrollView initWithFrame:CGRectMake(0, 0, MY_WIDTH, MY_HEIGHT)];
//    _photoScrollView.backgroundColor = [UIColor redColor];
//    [_photoScrollView setHidden:NO animation:YES];
    
    YYResPhotoView *photoScrollView = [[YYResPhotoView alloc] initWithFrame:CGRectMake(0, 64, MY_WIDTH, MY_HEIGHT-49-64)];
    photoScrollView.myBlock = ^(NSInteger indexNum){
        pageNum = indexNum;
    };
    [self.view addSubview:photoScrollView];
    [photoScrollView setPhotosWithPhotoDicArr:_imageS photoUrls:_urlArray currentIndex:(int)_indexNum currentFrame:CGRectMake(0, 0, 100, 100)];
    
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

- (IBAction)reply:(id)sender {
    //注释
    UIAlertView *createGroupAlert = [[UIAlertView alloc]initWithTitle:@"注释" message:nil
                                                             delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    createGroupAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *field = [createGroupAlert textFieldAtIndex:0];
    field.placeholder = @"1-8个字符";
   // createGroupAlert.backgroundColor = [UIColor yellowColor];
    createGroupAlert.tag = 222;
    [createGroupAlert show];
}
- (IBAction)praise:(id)sender {
    //赞
}
- (IBAction)comment:(id)sender {
    //评论
    ReplyPhotoVC *replyP = [[ReplyPhotoVC alloc] init];
    PhotoModel *model = _photoArr[pageNum];
    replyP.model = model;
    [self.navigationController pushViewController:replyP animated:YES];
    
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag ==222) {
        UITextField *field = [alertView textFieldAtIndex:0];
        if (buttonIndex) {
            if (field.text.length) {
                if(field.text.length>16)
                {
                    [SVProgressHUD showErrorWithStatus:@"分组名称太长了^_^"];
                }else{
                    //调用注释接口

                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"内容不能为空"];
            }
            

        }
        
    }
}


@end
