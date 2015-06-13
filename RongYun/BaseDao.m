//
//  BaseDao.m
//  RongYun
//
//  Created by 于君 on 15/5/7.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "BaseDao.h"

#import "FMDatabase.h"

@implementation BaseDao

-(void)createTable:(NSString *)sql
{
    FMDatabase *db = [[RTDatabaseHelper sharedInstance] openDatabase];
    if (![db executeUpdate:sql]) {
        DLog(@"Create table failed");
    }
    [db close];
}


@end
