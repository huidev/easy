//
//  NSString+Utils.h
//  RongYun
//
//  Created by 乐米科技 on 5/9/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)
/**
 *  去除字符串两边的空格
 *
 *  @return 删除空格后的字符串
 */
- (NSString*)trim;
/**
 *  去除多余的空格，包括字符串中间的空格
 *
 *  @return 删除空格后的字符串
 */
- (NSString*)trimRedundantWhiteSpace;

- (NSString *)MD5;

- (NSString *)replaceUnicodeToChinese;
@end
