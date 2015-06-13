//
//  ImageListView.m
//  DownloadImageDemo
//
//  Created by 小龙 薛 on 14-8-10.
//  Copyright (c) 2014年 Loong. All rights reserved.
//

#import "ImageListView.h"
#import "ZoomScrollView.h"

@interface ImageListView ()<UIScrollViewDelegate>{
    NSMutableArray *_dataArray;
    
    UILabel *_pageLabel;
    int _pageNum;
}

@end

@implementation ImageListView

@synthesize imageListScrollView = _imageListScrollView;

#define TOOLBAR_HEIGHT 50

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _dataArray = [[NSMutableArray alloc] init];
        
        
        
        self.backgroundColor = [UIColor blackColor];
        _imageListScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _imageListScrollView.delegate = self;
        _imageListScrollView.pagingEnabled = YES;
        _imageListScrollView.userInteractionEnabled = YES;
        _imageListScrollView.showsHorizontalScrollIndicator = NO;
        _imageListScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_imageListScrollView];
        
        _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - TOOLBAR_HEIGHT, self.frame.size.width, TOOLBAR_HEIGHT)];
        _pageLabel.textColor = [UIColor whiteColor];
        _pageLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_pageLabel];
        

    }
    return self;
}


- (void)setImagesWithArrayUrl:(NSArray *)array placeholderImageArray:(NSMutableArray *)placeholderArray clickedNum:(int)value clickView:(UIView *)view viewControllerView:(UIView *)controllerView{
    for (UIView *view in _imageListScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    _pageNum = (int)placeholderArray.count;
    _pageLabel.text = [NSString stringWithFormat:@"%d / %lu",value,(unsigned long)placeholderArray.count];
    _imageListScrollView.contentSize = CGSizeMake(array.count * _imageListScrollView.bounds.size.width, _imageListScrollView.bounds.size.height);
    _imageListScrollView.contentOffset = CGPointMake(_imageListScrollView.bounds.size.width * (value - 1) , 0);
    _dataArray = [NSMutableArray arrayWithArray:array];
    for (int i = 0; i < array.count; i ++) {
        
        if (i == value - 1)
        {
            continue;
        }
        UIImageView *iv = (UIImageView *)[view viewWithTag:i+1];
        
        ZoomScrollView *zsv = [[ZoomScrollView alloc] initWithFrame:CGRectMake(10 + i * [UIScreen mainScreen].bounds.size.width + i * 10 , 0, [UIScreen mainScreen].bounds.size.width , _imageListScrollView.bounds.size.height)
                                                           imageUrl:[array objectAtIndex:i]
                                                            orImage:nil
                                                andPlaceholderImage:[placeholderArray objectAtIndex:i]];
        
        
        CGRect initRect = [view convertRect:iv.frame toView:controllerView];
        [self setImageFrameWithView:zsv];
        zsv.imageView.initRect = initRect;
        [_imageListScrollView addSubview:zsv];
    }
    
    
    int num = value - 1;
    UIImageView *iv = (UIImageView *)[view viewWithTag:value];
    CGRect initRect = [iv.superview convertRect:iv.frame toView:controllerView];
    
    ZoomScrollView *zsv = [[ZoomScrollView alloc] initWithFrame:CGRectMake(10 + num * [UIScreen mainScreen].bounds.size.width + num * 10 , 0, [UIScreen mainScreen].bounds.size.width , _imageListScrollView.bounds.size.height)
                                                       imageUrl:[_dataArray objectAtIndex:num]
                                                        orImage:nil
                                            andPlaceholderImage:[placeholderArray objectAtIndex:num]];
    
    zsv.imageView.initRect = initRect;
    zsv.imageView.frame = initRect;
    [_imageListScrollView addSubview:zsv];
    
    
    [UIView animateWithDuration:0.3f animations:^{
        [self setImageFrameWithView:zsv];
        
    }];

}

- (void)setImageFrameWithView:(UIView *)view{
    ZoomScrollView *zsv = (ZoomScrollView *)view;
    if (zsv.imageView.image.size.width < zsv.imageView.image.size.height) {
        zsv.imageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - ([UIScreen mainScreen].bounds.size.height *zsv.imageView.image.size.width / zsv.imageView.image.size.height) / 2, 0, [UIScreen mainScreen].bounds.size.height *zsv.imageView.image.size.width / zsv.imageView.image.size.height, [UIScreen mainScreen].bounds.size.height);
    }else {
        zsv.imageView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height / 2 - ([UIScreen mainScreen].bounds.size.width * zsv.imageView.image.size.height / zsv.imageView.image.size.width) / 2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * zsv.imageView.image.size.height / zsv.imageView.image.size.width);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.frame.size.width;
    if (scrollView.contentOffset.x / width == [_dataArray count]) {
        [scrollView setContentOffset:CGPointZero animated:NO];
    }
    float page = scrollView.contentOffset.x / scrollView.frame.size.width;
    _pageLabel.text = [NSString stringWithFormat:@"%d / %d",(int)round(page) + 1,_pageNum];
}



- (void)removeAllchildScrollViews{
    for (UIView * view in self.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            [view removeFromSuperview];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
