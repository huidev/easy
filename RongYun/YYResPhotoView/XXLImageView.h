//
//  XXLImageView.h
//  DownloadImageDemo
//
//  Created by 小龙 薛 on 14-8-9.
//  Copyright (c) 2014年 Loong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXLImageView : UIImageView

@property (nonatomic , assign)CGRect initRect;

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)image failureImage:(UIImage *)image;

- (instancetype)initWithProgressView:(BOOL)value;

@end