//
//  XXLScrollView.m
//  DownloadImageDemo
//
//  Created by 小龙 薛 on 14-8-10.
//  Copyright (c) 2014年 Loong. All rights reserved.
//

#import "ZoomScrollView.h"
//#impo"

@interface ZoomScrollView ()<UIScrollViewDelegate>{

}

@end

@implementation ZoomScrollView

@synthesize imageView = _imageView;

- (id)initWithFrame:(CGRect)frame imageUrl:(NSURL *)url orImage:(UIImage *)image andPlaceholderImage:(UIImage *)placeholderImage
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        self.delegate = self;
        self.maximumZoomScale = 2.0;
        self.minimumZoomScale = 1.0;
//        self.showsHorizontalScrollIndicator = NO;
//        self.showsVerticalScrollIndicator = NO;
        _imageView = nil;
        
//        _imageView.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2 + 10, [UIScreen mainScreen].bounds.size.height / 2);

        if (url) {
            _imageView = [[XXLImageView alloc] initWithProgressView:YES];
            [_imageView setImageWithURL:url
                       placeholderImage:placeholderImage
                           failureImage:[UIImage imageNamed:@"remind_noimage"]];
        }
        if (image) {
            _imageView = [[XXLImageView alloc] initWithProgressView:NO];
            _imageView.image = image;
            _imageView.contentMode = UIViewContentModeScaleAspectFill;
            _imageView.clipsToBounds = YES;
        }
        

        [self addSubview:_imageView];
        
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeImageListView)];
//        [self addGestureRecognizer:tap];
    }
    return self;
}

//- (void)closeImageListView{
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:kFeedTableViewCellImageClose object:nil userInfo:nil];
//    [UIView animateWithDuration:0.3f animations:^{
//        self.imageView.frame = self.imageView.initRect;
//    }];
//    
//    
//}

#pragma mark - UIScrollViewDelegate

- (UIView*)viewForZoomingInScrollView:(UIScrollView*)scrollView{

    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    
    CGSize boundsSize = scrollView.bounds.size;
    CGRect imgFrame = _imageView.frame;
    CGSize contentSize = scrollView.contentSize;
    
    CGPoint centerPoint = CGPointMake(contentSize.width/2, contentSize.height/2);
    
    // center horizontally
    if (imgFrame.size.width <= boundsSize.width)
    {
        centerPoint.x = boundsSize.width/2;
    }
    
    // center vertically
    if (imgFrame.size.height <= boundsSize.height)
    {
        centerPoint.y = boundsSize.height/2;
    }
    
    _imageView.center = centerPoint;
}



//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    CGSize boundsSize = self.bounds.size;
//    CGRect viewFrame = _imageView.frame;
//    
//    if (viewFrame.size.width < boundsSize.width)
//        viewFrame.origin.x = (((boundsSize.width - viewFrame.size.width) / 2.0f) + self.contentOffset.x);
//    else
//        viewFrame.origin.x = 0.0f;
//    
//    if (viewFrame.size.height < boundsSize.height)
//        viewFrame.origin.y = (((boundsSize.height - viewFrame.size.height) / 2.0f) + self.contentOffset.y);
//    else
//        viewFrame.origin.y = 0.0f;
//    
//    _imageView.frame = viewFrame;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end