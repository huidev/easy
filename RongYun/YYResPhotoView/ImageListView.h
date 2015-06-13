//
//  ImageListView.h
//  DownloadImageDemo
//
//  Created by 小龙 薛 on 14-8-10.
//  Copyright (c) 2014年 Loong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageListScrollView;

@interface ImageListView : UIView

@property (nonatomic , strong) UIScrollView *imageListScrollView;

- (void)setImagesWithArrayUrl:(NSArray *)array placeholderImageArray:(NSMutableArray *)placeholderArray clickedNum:(int)value clickView:(UIView *)view viewControllerView:(UIView *)controllerView;


@end
