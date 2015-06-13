//
//  SectionView.m
//  CNMilitary
//
//  Created by 于君 on 15/5/6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SectionView.h"
#define HELF_HEIGHT 17
@implementation SectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:14];
        self.backgroundColor = UIColorFromRGBH(0x454647);
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [UIColorFromRGBH(0x2f3030) set];
    [_sectionText drawAtPoint:CGPointMake(13, 9) forWidth:textWidth withFont:_font fontSize:_font.pointSize lineBreakMode:NSLineBreakByCharWrapping baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    
    UIBezierPath *popoverPath = [UIBezierPath bezierPath];
    popoverPath.lineWidth = 0.3;
    [popoverPath moveToPoint:CGPointMake(0, HELF_HEIGHT)];
    [popoverPath addLineToPoint:CGPointMake(10, HELF_HEIGHT)];
    
    [popoverPath moveToPoint:CGPointMake(textWidth+10+6, HELF_HEIGHT)];
    [popoverPath addLineToPoint:CGPointMake(self.bounds.size.width, HELF_HEIGHT)];
    [popoverPath stroke];
}

- (void)setSectionText:(NSString *)sectionText
{
    _sectionText = sectionText;
    CGSize size = [sectionText sizeWithFont:_font constrainedToSize:CGSizeMake(self.bounds.size.width-30, 30) lineBreakMode:NSLineBreakByCharWrapping];
    textWidth = size.width;
    [self setNeedsDisplay];
}
@end
