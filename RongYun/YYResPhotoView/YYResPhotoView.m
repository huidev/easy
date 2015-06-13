//
//  YYResPhotoScrollView.m
//  Yummy
//
//  Created by Loong on 14-9-28.
//  Copyright (c) 2014年 xuexiaolong. All rights reserved.
//

#import "YYResPhotoView.h"
#import "ZoomScrollView.h"

@interface YYResPhotoView ()<UIScrollViewDelegate>{
    NSMutableArray *_photos;
    UIScrollView *_photoScrollerView;
    UILabel *_pageLabel;
}

@end

#define PAGELABEL_HEIGHT 50

@implementation YYResPhotoView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.userInteractionEnabled = YES;
        //容器scrollview
        _photoScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(- 10, 0, self.bounds.size.width + 20, self.bounds.size.height)];
        _photoScrollerView.pagingEnabled = YES;
        _photoScrollerView.delegate = self;
        [self addSubview:_photoScrollerView];

        //图片序号
        _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - PAGELABEL_HEIGHT - 60, self.bounds.size.width, PAGELABEL_HEIGHT)];
        _pageLabel.textColor = [UIColor whiteColor];
        _pageLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_pageLabel];
        
        _photos = [NSMutableArray arrayWithCapacity:0];
        
        
        
    }
    return self;
}
//自己加的
-(void)setPhotosWithPhotoDicArr:(NSMutableArray *)photos photoUrls:(NSMutableArray *)photoUrls currentIndex:(int)index currentFrame:(CGRect)frame{
    _photos = photos;
    //scrollview内容范围设置
    _photoScrollerView.contentSize = CGSizeMake(_photoScrollerView.bounds.size.width * photos.count, self.bounds.size.height-49);
    _photoScrollerView.contentOffset = CGPointMake(_photoScrollerView.bounds.size.width *index, 0);
    _pageLabel.text = [NSString stringWithFormat:@"%d / %d",index + 1,(int)_photos.count];
    
    [photoUrls enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL *stop) {
        
        //        NSString *urlStr = [self changeImageSize:[dict objectForKey:@"image"]];
        NSURL *bigImageUrl = [NSURL URLWithString:[dic objectForKey:@"url"]];
        
        UIImage *placeholderImage;
        if ([[photos objectAtIndex:idx] isKindOfClass:[UIImage class]]) {
            placeholderImage = [photos objectAtIndex:idx];
        }else{
            placeholderImage = [UIImage imageNamed:@"无网络默认3"];
        }
        
        //每一个图片所在的scrollview
        ZoomScrollView *zsv = [[ZoomScrollView alloc] initWithFrame:CGRectMake(10 + idx * _photoScrollerView.bounds.size.width , 0, _photoScrollerView.bounds.size.width - 20 , _photoScrollerView.bounds.size.height)
                                                           imageUrl:bigImageUrl
                                                            orImage:nil
                                                andPlaceholderImage:placeholderImage];
        CGSize s = CGSizeMake([[photoUrls[idx] objectForKey:@"width"] floatValue],  [[photoUrls[idx] objectForKey:@"height"] floatValue]);
        
        
        [self setImageFrameWithView:zsv WithSize:s];
        [_photoScrollerView addSubview:zsv];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeWithTap:)];
        //[zsv addGestureRecognizer:tap];
    }];
    
}

- (void)setPhotosWithArray:(NSMutableArray *)photos photoUrls:(NSMutableArray *)photoUrls currentIndex:(int)index currentFrame:(CGRect)frame{
    _photos = photos;
    
    _photoScrollerView.contentSize = CGSizeMake(_photoScrollerView.bounds.size.width * photos.count, self.bounds.size.height);
    _photoScrollerView.contentOffset = CGPointMake(_photoScrollerView.bounds.size.width *index, 0);
    _pageLabel.text = [NSString stringWithFormat:@"%d / %d",index + 1,(int)_photos.count];
    
    [photoUrls enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL *stop) {
        
//        NSString *urlStr = [self changeImageSize:[dict objectForKey:@"image"]];
        NSURL *bigImageUrl = [NSURL URLWithString:str];

        UIImage *placeholderImage;
        if ([[photos objectAtIndex:idx] isKindOfClass:[UIImage class]]) {
            placeholderImage = [photos objectAtIndex:idx];
        }else{
            placeholderImage = [UIImage imageNamed:@"无网络默认3"];
        }
        
     
        ZoomScrollView *zsv = [[ZoomScrollView alloc] initWithFrame:CGRectMake(10 + idx * _photoScrollerView.bounds.size.width , 0, _photoScrollerView.bounds.size.width - 20 , _photoScrollerView.bounds.size.height)
                                                           imageUrl:bigImageUrl
                                                            orImage:nil
                                                andPlaceholderImage:placeholderImage];
        
        [self setImageFrameWithView:zsv];
        [_photoScrollerView addSubview:zsv];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeWithTap:)];
        [zsv addGestureRecognizer:tap];
    }];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.frame.size.width;
    if (scrollView.contentOffset.x / width == [_photos count]) {
        [scrollView setContentOffset:CGPointZero animated:NO];
    }
    float page = scrollView.contentOffset.x / scrollView.frame.size.width;
    _pageLabel.text = [NSString stringWithFormat:@"%d / %d",(int)round(page) + 1,(int)_photos.count];
    NSLog(@"%f",page);
}

//滑动结束  page
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    float page = scrollView.contentOffset.x / scrollView.frame.size.width;
    NSLog(@"wefffff=%f",page);
    if (self.myBlock) {
        self.myBlock(page);
    }
}

- (void)closeWithTap:(UITapGestureRecognizer *)tap{
    [self setHidden:YES animation:YES];
    if (_showTabBarFlag == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowTabBar" object:nil];
    }
    


}
//自己加的
- (void)setImageFrameWithView:(UIView *)view WithSize:(CGSize)size{
    ZoomScrollView *zsv = (ZoomScrollView *)view;
    if (zsv.imageView.image.size.width < zsv.imageView.image.size.height) {
        //高度大的图片
        zsv.imageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - ([UIScreen mainScreen].bounds.size.height *zsv.imageView.image.size.width / zsv.imageView.image.size.height) / 2, 0, [UIScreen mainScreen].bounds.size.height *zsv.imageView.image.size.width / zsv.imageView.image.size.height, [UIScreen mainScreen].bounds.size.height);
    }else {
        //宽度大的图片
        NSLog(@"%f=%f",zsv.imageView.frame.size.width,zsv.imageView.frame.size.height);
        zsv.imageView.frame = CGRectMake(0, ([UIScreen mainScreen].bounds.size.height-64-49)/ 2 - ([UIScreen mainScreen].bounds.size.width * size.height / size.width) / 2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * size.height /size.width);
        NSLog(@"AAAAA%f=%f",zsv.imageView.frame.size.width,zsv.imageView.frame.size.height);

    }
}

- (void)setImageFrameWithView:(UIView *)view{
    ZoomScrollView *zsv = (ZoomScrollView *)view;
    if (zsv.imageView.image.size.width < zsv.imageView.image.size.height) {
        zsv.imageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - ([UIScreen mainScreen].bounds.size.height *zsv.imageView.image.size.width / zsv.imageView.image.size.height) / 2, 0, [UIScreen mainScreen].bounds.size.height *zsv.imageView.image.size.width / zsv.imageView.image.size.height, [UIScreen mainScreen].bounds.size.height);
    }else {
        zsv.imageView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height / 2 - ([UIScreen mainScreen].bounds.size.width * zsv.imageView.image.size.height / zsv.imageView.image.size.width) / 2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * zsv.imageView.image.size.height /zsv.imageView.image.size.width);
    }
}

- (NSString *)changeImageSize:(NSString *)url{
    
    NSString *search = @"/s/";
    NSString *replace = @"/b/";
    NSMutableString *newUrl = [NSMutableString stringWithString:url];
    NSRange substr = [url rangeOfString:search];
    if (substr.location != NSNotFound) {
        [newUrl replaceCharactersInRange:substr withString:replace];      //把第1个遇到的substr替换为replace
    }else{
        return url;
    }
    
    return newUrl;
}

- (void)hiddenComplete:(YYResPhotoViewBlock)resPhotoViewBlock {
    _resPhotoViewBlock = [resPhotoViewBlock copy];
}

- (void)setHidden:(BOOL)hidden {
    if (hidden) {
        self.alpha = 0.0f;
    }else{
        self.alpha = 1.0f;
    }
    [super setHidden:hidden];
}

- (void)setHidden:(BOOL)hidden animation:(BOOL)animation {
    if (animation) {
        if (hidden) {
            if (_resPhotoViewBlock) {
                _resPhotoViewBlock();
            }
            [UIView animateWithDuration:0.3f animations:^{
                self.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [super setHidden:hidden];
                [_photoScrollerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

            }];
        }else{
            [super setHidden:hidden];
            [UIView animateWithDuration:0.3f animations:^{
                self.alpha = 1.0f;
            }];
        }
    }else{
        if (hidden) {
            if (_resPhotoViewBlock) {
                _resPhotoViewBlock();
            }
            [super setHidden:hidden];
            [_photoScrollerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

        }else {
            
            [super setHidden:hidden];
            self.alpha = 1.0f;

        }
    }
}


@end
