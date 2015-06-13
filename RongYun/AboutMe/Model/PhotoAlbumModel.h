//
//  PhotoModel.h
//  RongYun
//
//  Created by apple on 15/5/26.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoAlbumModel : NSObject


@property (nonatomic,strong)NSString *a_name;//相册名字
@property (nonatomic,assign)NSInteger a_photo_count;
@property (nonatomic,strong)NSString *a_cover_ico;//相册封面
@property (nonatomic,strong)NSString *a_user_id;
@property (nonatomic,strong)NSString *a_id;
@end
