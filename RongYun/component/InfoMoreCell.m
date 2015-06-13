//
//  InfoMoreCell.m
//  RongYun
//
//  Created by 乐米科技 on 5/14/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "InfoMoreCell.h"
#import <AFNetworking/UIButton+AFNetworking.h>
#define WIDTH_ITEM 35
#define HEIGTH_ITME 50

@implementation InfoMoreCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    CGFloat space =(SCREENWIDTH*2/3-5*WIDTH_ITEM-60)/2;
//    for(UIView *view in self.contentView.subviews)
//    {
//        if (view.tag>99) {
//            long i=view.tag-100;
//            view.frame = CGRectMake(SCREENWIDTH/3+space+(WIDTH_ITEM+10)*i%5, space+(HEIGTH_ITME+10)*i/5, WIDTH_ITEM, HEIGTH_ITME);
//        }
//    }
}

- (void)setDataArray:(NSArray *)dataArray
{
    for(UIView *view in self.contentView.subviews)
    {
        if (view.tag>99) {
            [view removeFromSuperview];
        }
    }
    _dataArray = dataArray;
     CGFloat space =(SCREENWIDTH*2/3-5*WIDTH_ITEM-60)/2;
    for (int i=0; i<dataArray.count; i++) {
        self.emptyBT.hidden = YES;
        UIButton *itemBT = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBT.tag = 100+i;
        NSDictionary *dic = dataArray[i];
        [itemBT setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:dic[@"image"]]];
        NSAttributedString *titleStr = [[NSAttributedString alloc]initWithString:dic[@"title"] attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:10]}];
        [itemBT setAttributedTitle:titleStr forState:UIControlStateNormal];
        itemBT.frame = CGRectMake(SCREENWIDTH/3+space+(WIDTH_ITEM+10)*(i%5), space+(HEIGTH_ITME+10)*floorf(i/5.0), WIDTH_ITEM, HEIGTH_ITME);
        [itemBT setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 15, 0)];
        [itemBT setTitleEdgeInsets:UIEdgeInsetsMake(35, -50, 0, 0)];
        [self.contentView addSubview:itemBT];
    }
    if (!dataArray.count) {
        self.emptyBT.hidden = NO;
        [self.emptyBT setTitle:@"没有推荐的服务" forState:UIControlStateNormal];
    }
    [self layoutIfNeeded];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
