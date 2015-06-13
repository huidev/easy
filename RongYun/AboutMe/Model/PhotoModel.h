//
//  PhotoModel.h
//  RongYun
//
//  Created by apple on 15/5/27.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoModel : NSObject

@property (nonatomic,copy) NSString *p_src;
@property (nonatomic,assign) NSInteger p_comment_count;
@property (nonatomic,assign) NSInteger p_praise_count;

@property (nonatomic,copy) NSString *p_id;
@property (nonatomic,copy) NSString *p_create_date;
@property (nonatomic,copy) NSString *a_id;
@property (nonatomic,copy) NSString *p_user_id;


@end
