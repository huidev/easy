//
//  ShowPhotoVC.h
//  RongYun
//
//  Created by apple on 15/5/13.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "BaseViewController.h"
#import "PhotoAlbumModel.h"
@protocol ShowPhotoVCDelegate <NSObject>

-(void)pushImageList:(PhotoAlbumModel *)model;

@end

@interface ShowPhotoVC : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(weak,nonatomic)id<ShowPhotoVCDelegate>myDelegate;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic,assign)BOOL isMe;
@end
