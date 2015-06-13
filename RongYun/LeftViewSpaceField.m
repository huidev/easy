//
//  LeftViewSpaceField.m
//  fastHouse
//
//  Created by Mac on 14-6-20.
//  Copyright (c) 2014年 lemi. All rights reserved.
//
#import "LeftViewSpaceField.h"

#define LeftViewSpace 10
#define EditViewSpace (LeftViewSpace + 10)

@implementation LeftViewSpaceField

- (void)awakeFromNib
{
    self.text = @"";
    self.layer.borderColor = RGB(213, 213, 213).CGColor;
    self.layer.borderWidth = 1;
}

- (void)setBackgroudImageWith:(NSString *)location
{
    self.background = [[UIImage imageNamed:location] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
}

- (void)createLeftImageView:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = imageView;
}

- (void)createLeftLabel:(NSString *)text
{
    self.leftViewMode = UITextFieldViewModeAlways;
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = text;
    [label1 sizeToFit];
    label1.backgroundColor = [UIColor clearColor];
    label1.font = [UIFont systemFontOfSize:17];
    self.leftView = label1;
}
- (void)createRightLabel:(NSString *)text
{
    self.rightViewMode = UITextFieldViewModeAlways;
    UILabel *label2= [[UILabel alloc]init];
    label2.text = text;
    [label2 sizeToFit];
    label2.backgroundColor = [UIColor clearColor];
    label2.font =[UIFont systemFontOfSize:17];
    label2.textColor = UIColorFromRGB(0xCD2626);
    self.rightView = label2;
}
- (void)createRightImageView:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    self.rightViewMode = UITextFieldViewModeAlways;
    self.rightView = imageView;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect frame = self.leftView.frame;
    return CGRectMake(bounds.origin.x + frame.size.width + EditViewSpace, bounds.origin.y, bounds.size.width - frame.size.width - 2*EditViewSpace, bounds.size.height);
}
- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    CGRect frame = self.leftView.frame;
    return CGRectMake(bounds.origin.x + frame.size.width + EditViewSpace, bounds.origin.y, bounds.size.width - frame.size.width - 2*EditViewSpace, bounds.size.height);
}
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect frame = self.leftView.frame;
    return CGRectMake(bounds.origin.x + frame.size.width + EditViewSpace, bounds.origin.y, bounds.size.width - frame.size.width - 2*EditViewSpace, bounds.size.height);
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect frame = self.leftView.frame;
    return CGRectMake(bounds.origin.x + LeftViewSpace, (bounds.size.height - frame.size.height) / 2, frame.size.width, frame.size.height);
}
- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    CGRect frame = self.rightView.frame;
    return CGRectMake(self.frame.size.width- frame.size.width -5, (bounds.size.height - frame.size.height) / 2, frame.size.width, frame.size.height);
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(selectAll:))
        return NO;
    
    if (action == @selector(select:))
        return NO;
    
    if (action == @selector(cut:))
        return NO;
    
    if (action == @selector(copy:))
        return NO;
    
    if (action == @selector(paste:))
        return NO;
    return [super canPerformAction:action withSender:sender];
}

@end
