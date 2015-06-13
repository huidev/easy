//
//  BaseModelObject.m
//  CNMilitary
//
//  Created by 于君 on 15/5/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BaseModelObject.h"
#import <objc/runtime.h>
@implementation BaseModelObject

-(id)initWithDataDic:(NSDictionary*)data{
    if (self = [super init]) {
        if ([data isKindOfClass:[NSDictionary class]]) {
            [self setAttributes:data];
        }
    }
    return self;
}
-(NSDictionary*)attributeMapDictionary{
    return nil;
}
//获取一个类的属性名字列表
-(NSArray *)propertyNames:(Class)class {
    NSMutableArray *propertyNames = [[NSMutableArray alloc]init];
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(class, &propertyCount);
    for (unsigned int i =0; i<propertyCount; ++i) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        
        [propertyNames addObject:
         [NSString stringWithUTF8String:name]];
    }
    free(properties);
    return propertyNames;
}
-(SEL)getSetterSelWithAttibuteName:(NSString*)attributeName{
    NSString *capital = [[attributeName substringToIndex:1] uppercaseString];
    NSString *setterSelStr = [NSString stringWithFormat:@"set%@%@:",capital,[attributeName substringFromIndex:1]];
    return NSSelectorFromString(setterSelStr);
}
- (NSString *)customDescription{
    return nil;
}

- (NSString *)description{
    NSMutableString *attrsDesc = [NSMutableString stringWithCapacity:100];
    NSArray *attrMapDic = [self propertyNames:[self class]];
    NSEnumerator *keyEnum = [attrMapDic objectEnumerator];
    id attributeName;
    
    while ((attributeName = [keyEnum nextObject])) {
        SEL getSel = NSSelectorFromString(attributeName);
        if ([self respondsToSelector:getSel]) {
            NSMethodSignature *signature = nil;
            signature = [self methodSignatureForSelector:getSel];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:self];
            [invocation setSelector:getSel];
            NSObject *valueObj = nil;
            [invocation invoke];
            [invocation getReturnValue:&valueObj];
            if (valueObj) {
                [attrsDesc appendFormat:@" [%@=%@] ",attributeName,valueObj];
            }else {
                [attrsDesc appendFormat:@" [%@=nil] ",attributeName];
            }
            
        }
    }
    
    NSString *customDesc = [self customDescription];
    NSString *desc;
    
    if (customDesc && [customDesc length] > 0 ) {
        desc = [NSString stringWithFormat:@"%@:{%@,%@}",[self class],attrsDesc,customDesc];
    }else {
        desc = [NSString stringWithFormat:@"%@:{%@}",[self class],attrsDesc];
    }
    
    return desc;
}

-(void)setAttributes:(NSDictionary*)dataDic
{

    NSArray *property = [self propertyNames:[self class]];
//    NSDictionary *attrMapDic = [self attributeMapDictionary];
    if (property == nil) {
        return;
    }
//    NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
    NSEnumerator *keyEnum = [property objectEnumerator];
    id attributeName;
    while ((attributeName = [keyEnum nextObject])) {
        SEL sel = [self getSetterSelWithAttibuteName:attributeName];
        if ([self respondsToSelector:sel]) {
            NSString *dataDicKey = attributeName;
            NSString *value = nil;
            if ([dataDic isKindOfClass:[NSNull class]])
            {
                continue;
            }
            
            if ([[dataDic objectForKey:dataDicKey] isKindOfClass:[NSNumber class]]) {
                
                value = [[dataDic objectForKey:dataDicKey] stringValue];
                
                
            }else if([[dataDic objectForKey:dataDicKey] isKindOfClass:[NSNull class]]){
                value = nil;
            }else{
                value = [dataDic objectForKey:dataDicKey];
            }
            [self performSelectorOnMainThread:sel
                                   withObject:value
                                waitUntilDone:[NSThread isMainThread]];
            if (dataDic[@"id"]) {
                [self setValue:dataDic[@"id"] forKey:@"recordId"];
            }
        }
    }
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if( self = [super init] ){
//        NSDictionary *attrMapDic = [self attributeMapDictionary];
//        if (attrMapDic == nil) {
//            return self;
//        }
        NSArray *property = [self propertyNames:[self class]];
        NSEnumerator *keyEnum = [property objectEnumerator];
        id attributeName;
        while ((attributeName = [keyEnum nextObject])) {
            SEL sel = [self getSetterSelWithAttibuteName:attributeName];
            if ([self respondsToSelector:sel]) {
                id obj = [decoder decodeObjectForKey:attributeName];
                [self performSelectorOnMainThread:sel
                                       withObject:obj
                                    waitUntilDone:[NSThread isMainThread]];
            }
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder{
//    NSDictionary *attrMapDic = [self attributeMapDictionary];
//    if (attrMapDic == nil) {
//        return;
//    }
    NSArray *property = [self propertyNames:[self class]];
    NSEnumerator *keyEnum = [property objectEnumerator];
    id attributeName;
    while ((attributeName = [keyEnum nextObject])) {
        SEL getSel = NSSelectorFromString(attributeName);
        if ([self respondsToSelector:getSel]) {
            NSMethodSignature *signature = nil;
            signature = [self methodSignatureForSelector:getSel];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:self];
            [invocation setSelector:getSel];
            NSObject *valueObj;
            [invocation invoke];
            [invocation getReturnValue:&valueObj];
            if (valueObj) {
                [encoder encodeObject:valueObj forKey:attributeName];	
            }
        }
    }
}
- (NSData*)getArchivedData{
    return [NSKeyedArchiver archivedDataWithRootObject:self];
}

@end
