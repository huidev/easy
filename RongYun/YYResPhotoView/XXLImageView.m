//
//  XXLImageView.m
//  DownloadImageDemo
//
//  Created by 小龙 薛 on 14-8-9.
//  Copyright (c) 2014年 Loong. All rights reserved.
//

#import "XXLImageView.h"
#import "UIImageView+WebCache.h"
#import "DAProgressOverlayView.h"

@interface XXLImageView (){
    
}

@property (strong, nonatomic) DAProgressOverlayView *progressOverlayView;

@end

@implementation XXLImageView

@synthesize progressOverlayView = _progressOverlayView;
@synthesize initRect = _initRect;

- (instancetype)initWithProgressView:(BOOL)value
{
    self = [super init];
    if (self) {
        // Initialization code
        if (value) {
            _progressOverlayView = [[DAProgressOverlayView alloc] init];
            self.contentMode = UIViewContentModeScaleToFill;
            [self addSubview:self.progressOverlayView];
        }

        
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    _progressOverlayView.frame = self.bounds;
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage failureImage:(UIImage *)failureImage{
    
//    [self sd_setImageWithPreviousCachedImageWithURL:url andPlaceholderImage:placeholderImage options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        
//        float progress = MAX(0, MIN(1, receivedSize / (float) expectedSize));
//        dispatch_async(dispatch_get_main_queue(), ^{
//            _progressOverlayView.progress = progress;
//        });
//        
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (error) {
//                self.contentMode = UIViewContentModeCenter;
//                [self setImage:failureImage];
//            }else{
//                [self.progressOverlayView displayOperationDidFinishAnimation];
//                double delayInSeconds = self.progressOverlayView.stateChangeAnimationDuration;
//                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                    self.progressOverlayView.progress = 0.0f;
//                    [_progressOverlayView removeFromSuperview];
//                });
//            }
//            
//        });
//    }];
    
    [self sd_setImageWithURL:url
            placeholderImage:placeholderImage
                     options:SDWebImageRetryFailed
                    progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        float progress = MAX(0, MIN(1, receivedSize / (float) expectedSize));
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _progressOverlayView.progress = progress;
        });
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                self.contentMode = UIViewContentModeCenter;
                [self setImage:failureImage];
            }else{
                [self.progressOverlayView displayOperationDidFinishAnimation];
                double delayInSeconds = self.progressOverlayView.stateChangeAnimationDuration;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    self.progressOverlayView.progress = 0.0f;
                    [_progressOverlayView removeFromSuperview];
                });
            }

        });
    }];
}

@end
