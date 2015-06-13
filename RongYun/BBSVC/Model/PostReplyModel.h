//
//  PostReplyModel.h
//  RongYun
//
//  Created by apple on 15/5/29.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostReplyModel : NSObject

@property (nonatomic,assign) NSInteger id;
@property (nonatomic,assign) NSInteger is_reply;
@property (nonatomic,assign) NSInteger t_id;
@property (nonatomic,assign) NSInteger u_id;
@property (nonatomic,copy) NSString *t_content;
@property (nonatomic,copy) NSString *t_date;
@property (nonatomic,copy) NSString *t_photo;
@property (nonatomic,copy) NSString *u_ico;
@property (nonatomic,copy) NSString *u_name;
@property (nonatomic,copy) NSString *u_reply_content;

@end
