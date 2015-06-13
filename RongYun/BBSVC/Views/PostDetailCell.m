//
//  PostDetailCell.m
//  RongYun
//
//  Created by apple on 15/5/16.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "PostDetailCell.h"
#import "UIImageView+WebCache.h"
@implementation PostDetailCell

- (void)awakeFromNib {
    // Initialization code
}

+(CGFloat)cellHeight1:(PostModel *)postModel{
    NSMutableArray *imageArr = [[NSMutableArray alloc] init];
    NSString *str = postModel.t_photo;
    if (str.length) {
        while (1) {
            NSRange range = [str rangeOfString:@"|"];
            if (range.length == 0) {
                [imageArr addObject:str];
                break;
            }
            NSString *subStr = [str substringWithRange:NSMakeRange(0, range.location)];
            [imageArr addObject:subStr];
            str = [str substringWithRange:NSMakeRange(range.location+1, str.length-range.location-1)];
        }
    }

    float temp = imageArr.count==0?0:8;
    return (325-100-82)+imageArr.count*(150+8)+temp;
}

+(CGFloat)cellHeight2:(PostReplyModel *)postReplyModel{
    NSMutableArray *imageArr = [[NSMutableArray alloc] init];
    NSString *str = postReplyModel.t_photo;
    if (str.length) {
        while (1) {
            NSRange range = [str rangeOfString:@"|"];
            if (range.length == 0) {
                [imageArr addObject:str];
                break;
            }
            NSString *subStr = [str substringWithRange:NSMakeRange(0, range.location)];
            [imageArr addObject:subStr];
            str = [str substringWithRange:NSMakeRange(range.location+1, str.length-range.location-1)];
        }
    }

    float replyBgViewHeight;
    if (postReplyModel.is_reply == 0) {
        replyBgViewHeight = 100;
    }else{
        replyBgViewHeight = 0;
    }
    
    float temp = imageArr.count==0?0:8;
    return (325-replyBgViewHeight-82)+imageArr.count*(150+8)+temp;
}

// 帖子
-(void)setPostModel:(PostModel *)postModel{

    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_replyView(0)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_replyView)]];
    _replyView.hidden = YES;

    _signatureLab.text = postModel.u_endorse;
    _titleLab.text = postModel.t_title;
    
    [_porImage sd_setImageWithURL:[NSURL URLWithString:postModel.u_ico] placeholderImage:nil];
    _phoneLab.text = postModel.u_name;
    _detailLab.text = postModel.t_content;
    _dateLab.text = postModel.t_create_date;
    
    NSMutableArray *imageArr = [[NSMutableArray alloc] init];
    NSString *str = postModel.t_photo;
    if (postModel.t_photo.length) {
        while (1) {
            NSRange range = [str rangeOfString:@"|"];
            if (range.length == 0) {
                [imageArr addObject:str];
                break;
            }
            NSString *subStr = [str substringWithRange:NSMakeRange(0, range.location)];
            [imageArr addObject:subStr];
            str = [str substringWithRange:NSMakeRange(range.location+1, str.length-range.location-1)];
        }
    }
    
    switch (imageArr.count) {
        case 0:
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_imageBgView(0)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageBgView)]];
            
            break;
        case 1:
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_imageBgView(166)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageBgView)]];
            
            break;
        case 2:
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_imageBgView(166+158)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageBgView)]];
            
            break;
        case 3:
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_imageBgView(166+158*2)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageBgView)]];
            break;
        default:
            break;
    }
    
    //图片顶部  底部 和图片之间的间隔是8
    //模型上图片个数 和 view上图片个数对不
    NSInteger imageCount = _imageBgView.subviews.count;
    for (int i = 0; i<imageCount; i++) {
        
        [_imageBgView.subviews[0] removeFromSuperview];
        
    }
    if (imageArr.count) {
        NSInteger num = imageArr.count - _imageBgView.subviews.count;
        switch (num) {
            case 1:
                for (int i = 0; i<1; i++) {
                    UIImageView *imageV = [[UIImageView alloc] init];
                    imageV.frame = CGRectMake((_imageBgView.frame.size.width-80)/2, 8+(150+8)*i,80, 150);
                    [imageV sd_setImageWithURL:[NSURL URLWithString:imageArr[0]] placeholderImage:nil];
                    [self.imageBgView addSubview:imageV];
                }
                break;
            case 2:
                for (int i = 0; i<2; i++) {
                    UIImageView *imageV = [[UIImageView alloc] init];
                    imageV.frame = CGRectMake((_imageBgView.frame.size.width-80)/2, 8+(150+8)*i,80, 150);
                    [imageV sd_setImageWithURL:[NSURL URLWithString:imageArr[1]] placeholderImage:nil];
                    [self.imageBgView addSubview:imageV];
                }
                break;
            case 3:
                for (int i = 0; i<3; i++) {
                    UIImageView *imageV = [[UIImageView alloc] init];
                    imageV.frame = CGRectMake((_imageBgView.frame.size.width-80)/2, 8+(150+8)*i,80, 150);
                    [imageV sd_setImageWithURL:[NSURL URLWithString:imageArr[2]] placeholderImage:nil];
                    [self.imageBgView addSubview:imageV];
                }
                break;
            default:
                break;
        }
    }
}

//帖子的评论
- (void)setModel:(PostReplyModel *)postReplyModel{
    
    if (postReplyModel.is_reply == 0) {
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_replyView(0)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_replyView)]];
        _replyView.hidden = YES;
    }else{
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_replyView(100)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_replyView)]];
        _replyView.hidden = NO;

    }
    
    [_porImage sd_setImageWithURL:[NSURL URLWithString:postReplyModel.u_ico] placeholderImage:nil];
    _phoneLab.text = postReplyModel.u_name;
    _detailLab.text = postReplyModel.t_content;
    _dateLab.text = postReplyModel.t_date;
    NSMutableArray *imageArr = [[NSMutableArray alloc] init];
    NSString *str = postReplyModel.t_photo;
    if (postReplyModel.t_photo.length) {
        while (1) {
            NSRange range = [str rangeOfString:@"|"];
            if (range.length == 0) {
                [imageArr addObject:str];
                break;
            }
            NSString *subStr = [str substringWithRange:NSMakeRange(0, range.location)];
            [imageArr addObject:subStr];
            str = [str substringWithRange:NSMakeRange(range.location+1, str.length-range.location-1)];
        }
    }
    switch (imageArr.count) {
        case 0:
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_imageBgView(0)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageBgView)]];
            break;
        case 1:
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_imageBgView(166)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageBgView)]];
            break;
        case 2:
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_imageBgView(166+158)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageBgView)]];
            
            break;
        case 3:
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_imageBgView(166+158*2)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageBgView)]];
            break;
        default:
            break;
    }

    //图片顶部  底部 和图片之间的间隔是8
    //模型上图片个数 和 view上图片个数对不
    NSInteger imageCount = _imageBgView.subviews.count;
    for (int i = 0; i<imageCount; i++) {

        [_imageBgView.subviews[0] removeFromSuperview];
        
    }
    if (imageArr.count) {
        NSInteger num = imageArr.count - _imageBgView.subviews.count;
        switch (num) {
            case 1:
                for (int i = 0; i<1; i++) {
                    UIImageView *imageV = [[UIImageView alloc] init];
                    imageV.frame = CGRectMake((_imageBgView.frame.size.width-80)/2, 8+(150+8)*i,80, 150);
                    [imageV sd_setImageWithURL:[NSURL URLWithString:imageArr[0]] placeholderImage:nil];
                    [self.imageBgView addSubview:imageV];
                }
                break;
            case 2:
                for (int i = 0; i<2; i++) {
                    UIImageView *imageV = [[UIImageView alloc] init];
                    imageV.frame = CGRectMake((_imageBgView.frame.size.width-80)/2, 8+(150+8)*i,80, 150);
                    [imageV sd_setImageWithURL:[NSURL URLWithString:imageArr[1]] placeholderImage:nil];
                    [self.imageBgView addSubview:imageV];
                }
                break;
            case 3:
                for (int i = 0; i<3; i++) {
                    UIImageView *imageV = [[UIImageView alloc] init];
                    imageV.frame = CGRectMake((_imageBgView.frame.size.width-80)/2, 8+(150+8)*i,80, 150);
                    [imageV sd_setImageWithURL:[NSURL URLWithString:imageArr[2]] placeholderImage:nil];
                    [self.imageBgView addSubview:imageV];
                }
                break;
            default:
                break;
        }
    }

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)report:(id)sender {
}

- (IBAction)reply:(id)sender {
}
@end
