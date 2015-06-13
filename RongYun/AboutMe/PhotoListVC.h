//
//  ImageListVC.h
//  RongYun
//
//  Created by apple on 15/5/14.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoAlbumModel.h"
#import "BaseViewController.h"

@interface PhotoListVC : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) PhotoAlbumModel *photoModel;

@end
