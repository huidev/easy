//
//  XXLScrollView.h
//  DownloadImageDemo
//
//  Created by 小龙 薛 on 14-8-10.
//  Copyright (c) 2014年 Loong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXLImageView.h"


@interface ZoomScrollView : UIScrollView

@property (nonatomic , strong)XXLImageView *imageView;


- (id)initWithFrame:(CGRect)frame imageUrl:(NSURL *)url orImage:(UIImage *)image andPlaceholderImage:(UIImage *)placeholderImage;

@end
