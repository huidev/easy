//
//  BaseModelObject.h
//  CNMilitary
//
//  Created by 于君 on 15/5/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModelObject :NSObject <NSCoding> {
    
}

/**
 *  根据json
 *
 *  @param data <#data description#>
 *
 *  @return <#return value description#>
 */
-(id)initWithDataDic:(NSDictionary*)data;

- (NSDictionary*)attributeMapDictionary;

- (void)setAttributes:(NSDictionary*)dataDic;

- (NSString *)customDescription;

- (NSString *)description;

- (NSData*)getArchivedData;

@end
