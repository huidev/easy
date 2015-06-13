//
//  MyPhotoVC.m
//  RongYun
//
//  Created by apple on 15/5/13.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "MyPhotoVC.h"
#import "NewCreatPhotoVC.h"
#import "PhotoListVC.h"
#import "PhotoSingleton.h"
#import <QiniuSDK.h>


@interface MyPhotoVC ()

@end

@implementation MyPhotoVC

- (void)viewWillAppear:(BOOL)animated{

}

- (void)viewDidAppear:(BOOL)animated{
    [self uploadAblumToQiniu];
}

- (void)uploadAblumToQiniu{
    
    if ([PhotoSingleton sharedManager].beginUpload) {
        [SVProgressHUD showWithStatus:@"上传中请稍等"];
        //上传相册
        // 获得当前时间戳 用作   照片名字
        NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
        long long int date = (long long int)time;
        NSLog(@"date ===== %lld", date); //1295322949

        NSMutableArray *imageNameArr = [[NSMutableArray alloc] init];
        for (int i = 0; i<[PhotoSingleton sharedManager].photoArr.count; i++) {
            [imageNameArr addObject:[NSString stringWithFormat:@"%lld",date+i]];
        }
        //将所有的图片转为data
        NSMutableArray *imageDataArr = [[NSMutableArray alloc] init];
        for (int i = 0; i<[PhotoSingleton sharedManager].photoArr.count; i++) {
            UIImage *image = [PhotoSingleton sharedManager].photoArr[i];
            NSData* data;
            if (UIImagePNGRepresentation(image)) {
                //返回为png图像。
                data = UIImagePNGRepresentation(image);
            }else {
                //返回为JPEG图像。
                data = UIImageJPEGRepresentation(image, 0.8);
            }
            [imageDataArr addObject:data];
        }
        //获得token
        __block NSString *qiNiuToken;
        NSDictionary *dic = @{@"type":@"album",@"f_name":@"""",};
        NSLog(@"%@",dic);
        self.httpRequest = [WHHttpClient defaultClient];
        [self.httpRequest requestWithPath:URL_QiniuToken method:RTHttpRequestGet parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            qiNiuToken = responseObject;
            __block NSInteger sucCount = 0;
            __block NSInteger   errorCount = 0;
            //上传照片到七牛
            for (int i = 0; i<[PhotoSingleton sharedManager].photoArr.count; i++) {
                QNUploadManager *upManager = [[QNUploadManager alloc] init];
                NSData *data = imageDataArr[i];
                [upManager putData:data key:imageNameArr[i] token:qiNiuToken complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                    NSLog(@"%@", info);
                    NSLog(@"%@", resp);

                    if (info.statusCode == 200) {
                        sucCount++;
                    }else{
                        errorCount++;
                    }
                    if (sucCount+errorCount == [PhotoSingleton sharedManager].photoArr.count) {
                        //清理单例中   相册的信息
                        [PhotoSingleton sharedManager].beginUpload = NO;
                        NSLog(@"已经上传%ld张照片到到Qiniu",(long)sucCount);
                        NSLog(@"%ld张失败",(long)errorCount);
                        NSString *a_cover_ico;
                        NSMutableString *a_photo = [[NSMutableString alloc] init];
                        for (int i = 0; i<imageNameArr.count; i++) {
                            if (i==0) {
                                a_cover_ico = imageNameArr[0];
                            }else if(i == 1){
                                [a_photo appendFormat:@"%@",imageNameArr[1]];
                            }else{
                                [a_photo appendFormat:@"|%@",imageNameArr[i]];
                            }

                        }
                        
                        //得到共建人信息
                        NSDictionary *param = @{@"otype":@"getc",@"u_id":@"1",@"f_type":@"-1"};
                        self.httpRequest = [WHHttpClient defaultClient];
                        [self.httpRequest requestWithPath:URL_USER_LOGIN method:RTHttpRequestGet parameters:param prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                            //数组转json
                            NSError *error = nil;
                            NSString *jsonString;
                            //NSJSONWritingPrettyPrinted:指定生成的JSON数据应使用空格旨在使输出更加可读。如果这个选项是没有设置,最紧凑的可能生成JSON表示。
                            NSData *jsonData = [NSJSONSerialization
                                                dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:&error];
                            if ([jsonData length] > 0 && error == nil){
                                jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                            }
                            if ([[PhotoSingleton sharedManager].albumType intValue] == 2) {
                                [PhotoSingleton sharedManager].a_user = jsonString;
                            }else{
                                [PhotoSingleton sharedManager].a_user = @"";
                            }
                            
                            //告诉服务器 你给Qiniu上传的情况
                            NSDictionary *param = @{@"otype":@"adda",@"u_id":@"1",@"a_name":[PhotoSingleton sharedManager].albumName,@"a_type":[PhotoSingleton sharedManager].albumType,@"a_cover_ico":a_cover_ico,@"a_photo":a_photo,@"a_user":[PhotoSingleton sharedManager].a_user};
                            self.httpRequest = [WHHttpClient defaultClient];
                            [self.httpRequest requestWithPath:URL_PHOTO_LIST method:RTHttpRequestGet parameters:param prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                                if ([responseObject isEqualToString:@"succeed"]) {
                                    [SVProgressHUD dismiss];
                                }
                            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                NSLog(@"error=%@",error);
                                [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
                            }];
                            
                            
                        } failure:^(NSURLSessionDataTask *task, NSError *error) {
                        }];
                        
                        // 判断是个人相册  还是  共享相册


                    }
                } option:nil];
            }

        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error=%@",error);
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }];
 
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configSubviews];
    [self loadPhotoWithType:@"1"];

    
    
}

- (void)loadPhotoWithType:(NSString *)typeStr{
//    NSDictionary *param = @{@"u_id":@"20",@"a_type":typeStr,@"index":@"1"};
//    self.httpRequest = [WHHttpClient defaultClient];
//
//    [self.httpRequest requestWithPath:URL_PHOTO_LIST method:RTHttpRequestPost parameters:param prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"responseObject=%@",responseObject);
//        NSError *error;
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject   options:NSJSONReadingMutableLeaves error:&error];
//        NSLog(@"%@",dic);
//
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"error=%@",error);
//        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
//    }];
    
    
//    NSDictionary *param = @{@"otype":@"addF",@"u_id":@"1",@"u_ico":@"http://img0.bdstatic.com/img/image/shouye/dongman0401.jpg",@"f_ico":@"http://img0.bdstatic.com/img/image/shouye/bizhi0520.jpg",@"f_name":@"论坛名字",@"f_city":@"太原",@"f_des":@"简介",@"f_type":@"综合论坛",};
//    self.httpRequest = [WHHttpClient defaultClient];
//    [self.httpRequest requestWithPath:@"/justHomeApi/ForumApi" method:RTHttpRequestPost parameters:param prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"responseObject=%@",responseObject);
//        NSError *error;
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject   options:NSJSONReadingMutableLeaves error:&error];
//        NSLog(@"%@",dic);
//        
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"error=%@",error);
//        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
//    }];


}

- (void)configSubviews;
{
    UIBarButtonItem *rigthBar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(barButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = rigthBar;
    
    _slideSwitchView.topScrollView.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.slideSwitchView.tabItemNormalColor = [LYHSlideSwitchView colorFromHexRGB:@"868686"];
    self.slideSwitchView.tabItemSelectedColor = [LYHSlideSwitchView colorFromHexRGB:@"bb0b15"];
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    
    self.perPhotoVC = [[ShowPhotoVC alloc] init];
    self.perPhotoVC.title = @"个人相册";
    self.perPhotoVC.myDelegate = self;

    self.familyPhotoVC = [[ShowPhotoVC alloc] init];
    self.familyPhotoVC.title = @"家庭相册";
    self.familyPhotoVC.myDelegate = self;
    
    self.cloudPhotoVC = [[ShowPhotoVC alloc] init];
    self.cloudPhotoVC.title = @"共享相册";
    self.cloudPhotoVC.myDelegate =self;
    
    UIButton *rightSideButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightSideButton setImage:[UIImage imageNamed:@"icon_rightarrow.png"] forState:UIControlStateNormal];
    [rightSideButton setImage:[UIImage imageNamed:@"icon_rightarrow.png"]  forState:UIControlStateHighlighted];
    rightSideButton.frame = CGRectMake(0, 0, 0.0f, 44.0f);
    rightSideButton.userInteractionEnabled = NO;
    self.slideSwitchView.rigthSideButton = rightSideButton;
    self.slideSwitchView.slideSwitchViewDelegate = self;
    [self.slideSwitchView buildUI];
    
    //[self getTokenFromServer];
    
}

- (void)creatAlbum{
    NSDictionary *param = @{@"otype":@"adda",@"u_id":@"1",@"a_name":@"xiangpian",@"a_type":@"1",@"a_cover_ico":@"fengmian",@"otype":@"adda",@"otype":@"adda",};
    self.httpRequest = [WHHttpClient defaultClient];
    
    [self.httpRequest requestWithPath:URL_PHOTO_LIST method:RTHttpRequestGet parameters:param prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject   options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"%@",dic);
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error=%@",error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

- (void)getTokenFromServer{
    
    NSDictionary *param = @{@"type":@"froum",@"f_name":@"123"};
    self.httpRequest = [WHHttpClient defaultClient];
    
    [self.httpRequest requestWithPath:URL_GETTOKEN_LIST method:RTHttpRequestGet parameters:param prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject   options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"%@",dic);
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error=%@",error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

//    NSDictionary *dic = @{@"type":@"froum",@"f_name":@"123"};
//    
//    
//    [self requestGetWithRelativeUrl:URL_GETTOKEN_LIST parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@",responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//     NSLog(@"%@",error);
//    }];
    
}

- (void)barButtonItemAction:(UIBarButtonItem *)barItem
{

    if (barItem ==self.navigationItem.rightBarButtonItem) {
        NewCreatPhotoVC *creatPhoto = [[NewCreatPhotoVC alloc] init];
        [self.navigationController pushViewController:creatPhoto animated:YES];
    }
}
#pragma mark ShowPhotoVCDelegate
-(void)pushImageList:(PhotoAlbumModel *)model{
    PhotoListVC *imageList = [[PhotoListVC alloc] init];
    imageList.photoModel = model;
    [self.navigationController pushViewController:imageList animated:YES];
}

#pragma mark LYHSlideSwitchViewDelegate
- (NSUInteger)numberOfTab:(LYHSlideSwitchView *)view
{
    return 3;
}

- (UIViewController *)slideSwitchView:(LYHSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    if (number == 0) {
        return self.perPhotoVC;
    } else if (number == 1) {
        return self.familyPhotoVC;
    } else if (number == 2) {
        return self.cloudPhotoVC;
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
        vc = self.perPhotoVC;
    } else if (number == 1) {
        vc = self.familyPhotoVC;
    } else if (number == 2) {
        vc = self.cloudPhotoVC;
    }
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
