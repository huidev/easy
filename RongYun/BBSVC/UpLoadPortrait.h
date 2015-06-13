//
//  UpLoadPortrait.h
//  RongYun
//
//  Created by apple on 15/6/5.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "BaseViewController.h"
#import "DoImagePickerController1.h"

@interface UpLoadPortrait : BaseViewController<UITextFieldDelegate,UITextViewDelegate,DoImagePickerControllerDelegate1,UIAlertViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
}

@property (strong,nonatomic)UIImage *coverImage;
@property (strong,nonatomic)NSMutableArray *upLoadImageArr;
@property (strong, nonatomic)NSMutableArray *cameraArr;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *imageLab;

@end
