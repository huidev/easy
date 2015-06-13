//
//  YYResPhotoScrollView.h
//  Yummy
//
//  Created by Loong on 14-9-28.
//  Copyright (c) 2014年 xuexiaolong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^YYResPhotoViewBlock) (void);

@interface YYResPhotoView : UIView {
    YYResPhotoViewBlock _resPhotoViewBlock;
}

@property(nonatomic,strong) void(^myBlock)(NSInteger index);
@property (nonatomic,assign)NSInteger showTabBarFlag;

- (void)setPhotosWithArray:(NSMutableArray *)photos photoUrls:(NSMutableArray *)photoUrls currentIndex:(int)index currentFrame:(CGRect)frame;

- (void)setPhotosWithPhotoDicArr:(NSMutableArray *)photos photoUrls:(NSMutableArray *)photoUrls currentIndex:(int)index currentFrame:(CGRect)frame;

- (void)setHidden:(BOOL)hidden animation:(BOOL)animation;

- (void)hiddenComplete:(YYResPhotoViewBlock)resPhotoViewBlock;

@end
