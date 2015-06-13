//
//  photoDetailVC.h
//  RongYun
//
//  Created by apple on 15/6/8.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "BaseViewController.h"
#import "YYResPhotoView.h"

@interface PhotoDetailVC : UIViewController

@property (nonatomic,strong)NSMutableArray *photoArr;

@property (nonatomic,strong)NSMutableArray *imageS;
@property (nonatomic,strong)NSMutableArray *urlArray;
@property (nonatomic,assign)NSInteger indexNum;

@property (strong, nonatomic) IBOutlet YYResPhotoView *photoScrollView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *replyBtn;
- (IBAction)reply:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;
- (IBAction)praise:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *commendtBtn;
- (IBAction)comment:(id)sender;

@end
