//
//  PhotoSingle.h
//  RongYun
//
//  Created by apple on 15/6/6.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoSingleton : NSObject

@property (nonatomic,copy)NSString *coverName;
@property (nonatomic,copy)NSString *albumName;
@property (nonatomic,copy)NSString *albumType;
@property (nonatomic,copy)NSString *a_user;
@property (nonatomic,strong)NSMutableArray *photoArr;
@property (nonatomic,strong)NSMutableArray *photoNameArr;
@property (nonatomic,assign)BOOL beginUpload;


+ (PhotoSingleton *)sharedManager;

@end
