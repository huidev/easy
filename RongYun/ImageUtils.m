//
//  ImageUtils.m
//  RongYun
//
//  Created by 乐米科技 on 5/8/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "ImageUtils.h"

#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@implementation ImageUtils

+ (UIImage*)captureView:(UIView*)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage*)noCachedImageNamed:(NSString *)name
{
    if(name == nil)
        return nil;
    NSString* imageFile = [[NSString alloc] initWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],name];
    UIImage* image = [[UIImage alloc] initWithContentsOfFile:imageFile];
    return image;
}

+ (UIImage*)stretchableImageNamed:(NSString*)name
{
    if(name == nil)
        return nil;
    UIImage* image = [UIImage imageNamed:name];
    UIImage* stretchableImage = [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2];
    return stretchableImage;
}

+ (UIImage*)stretchableNotCachedImageNamed:(NSString*)name
{
    if(name == nil)
        return nil;
    NSString* imageFile = [[NSString alloc] initWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],name];
    UIImage* image = [[UIImage alloc] initWithContentsOfFile:imageFile];
    UIImage* stretchableImage = [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2];
    return stretchableImage;
}

+ (UIImage *)addText:(UIImage *)img text:(NSString *)someText{
    int w = img.size.width;
    int h = img.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst |kCGBitmapByteOrder32Little);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    
    char* text= (char *)[someText cStringUsingEncoding:NSASCIIStringEncoding];
    CGContextSelectFont(context, "Arial",20, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
    CGContextShowTextAtPoint(context,10,10,text, strlen(text));
    CGImageRef imgCombined = CGBitmapContextCreateImage(context);
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *retImage = [UIImage imageWithCGImage:imgCombined];
    CGImageRelease(imgCombined);
    
    return retImage;
}

+ (void)setImageCenterWihtImageView:(UIImageView *)imageView
{
    if (!imageView.image) return;
    UIImage *image = imageView.image;
    
    float rateX = image.size.width/imageView.frame.size.width;
    float rateY = image.size.height/imageView.frame.size.height;
    if (rateX >= 1 && rateY >= 1) {
        if (rateX >= rateY) {
            float orginX = (imageView.frame.size.width-image.size.width/rateY)/2.0;
            imageView.frame = CGRectMake(orginX, 0, image.size.width/rateY, imageView.frame.size.height);
        }else{
            float orginY = (imageView.frame.size.height-image.size.height/rateX)/2.0;;
            imageView.frame = CGRectMake(0, orginY, imageView.frame.size.width, image.size.height/rateX);
        }
    }else if (rateX < 1 && rateY < 1){
        if (rateX >= rateY) {
            float orginX = (image.size.width-imageView.frame.size.width/rateY)/2.0;
            imageView.frame = CGRectMake(orginX, 0, imageView.frame.size.width/rateY, image.size.height);
        }else{
            float orginY = (image.size.height-imageView.frame.size.height/rateX)/2.0;;
            imageView.frame = CGRectMake(0, orginY, image.size.width, imageView.frame.size.height/rateX);
        }
    }else{
        
    }
}

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
