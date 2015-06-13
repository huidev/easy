//
//  replyPostVC.h
//  RongYun
//
//  Created by apple on 15/5/23.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "BaseViewController.h"
#import "QEDTextView.h"
typedef enum {
    ReplyPhoto,
    ReplyPost
}ReplyType;

@interface ReplyVC : BaseViewController<UITextViewDelegate>

@property (assign,nonatomic) ReplyType replyType;
@property (strong, nonatomic) QEDTextView *textView;

@end
