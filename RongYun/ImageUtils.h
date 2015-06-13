//
//  ImageUtils.h
//  RongYun
//
//  Created by 乐米科技 on 5/8/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageUtils : NSObject

//截取view当前的image对象
+ (UIImage*)captureView:(UIView*)view;

//创建不缓存image对象
+ (UIImage*)noCachedImageNamed:(NSString *)name;

//创建可拉伸image对象(缓存)
+ (UIImage*)stretchableImageNamed:(NSString*)name;

//创建可拉伸image对象(不缓存)
+ (UIImage*)stretchableNotCachedImageNamed:(NSString*)name;

//图片上添加文字
+ (UIImage *)addText:(UIImage *)img text:(NSString *)someText;

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

@end
