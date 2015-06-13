//
//  SectionView.h
//  CNMilitary
//
//  Created by 于君 on 15/5/6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionView : UIView
{
    CGFloat textWidth;
}
@property (nonatomic, strong)NSString *sectionText;
@property (nonatomic, strong)UIFont *font;
@end
