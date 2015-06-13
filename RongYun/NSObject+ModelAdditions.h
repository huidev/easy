//
//  NSObject+ModelAdditions.h
//  RongYun
//
//  Created by 乐米科技 on 5/9/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ModelAdditions)
- (id)initWithDict:(id)dict;
- (void)autoParseWithDict:(NSDictionary*)dict;

- (NSDictionary*)genJsonDic;
- (NSDictionary*)genJsonDic:(BOOL)isUse withKeyList:(NSString *)firstKey,...NS_REQUIRES_NIL_TERMINATION;

- (NSString*)customDescription;
@end
