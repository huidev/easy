//
//  NSObject+ModelAdditions.m
//  RongYun
//
//  Created by 乐米科技 on 5/9/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "NSObject+ModelAdditions.h"

#import "NSString+Utils.h"
#import <objc/runtime.h>

@implementation NSObject (ModelAdditions)

- (id)initWithDict:(id) dict {
    if (self) {
        if (dict&&[dict isKindOfClass:[NSDictionary class]]){
            [self autoParseWithDict:dict];
        }
    }
    return self;
}

- (void)autoParseWithDict:(NSDictionary*)dict{
    Class currentClass = [self class];
    do {
        unsigned int propCount, i;
        objc_property_t* properties = class_copyPropertyList(currentClass, &propCount);
        for (i = 0; i < propCount; i++) {
            objc_property_t prop = properties[i];
            const char *propName = property_getName(prop);
            if(propName) {
                //            const char *propType = getPropertyType(prop);
                NSString *name = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
                //            NSString *type = [NSString stringWithCString:propType encoding:NSUTF8StringEncoding];
                id obj = [dict objectForKey:name];
                if (!obj || [obj isEqual:[NSNull null]])  {
                    continue;
                }
                [self setValue:obj forKey:name];
            }
        }
        free(properties);
        currentClass = [currentClass superclass];
    } while ([currentClass superclass]);
    
    
    //所有的id都转换为recordId
    if (dict[@"id"]) {
        [self setValue:dict[@"id"] forKey:@"recordId"];
    }
}

- (NSDictionary*)genJsonDic{
    return [self genJsonDic:NO withKeyList:nil];
}

- (NSDictionary*)genJsonDic:(BOOL)isUse withKeyList:(NSString *)firstKey, ...{
    
    id eachObject;
    va_list argumentList;
    NSMutableString *strArgument = [NSMutableString string];
    if (firstKey) // The first argument isn't part of the varargs list,
    {                                   // so we'll handle it separately.
        [strArgument appendFormat:@",%@",firstKey];
        va_start(argumentList, firstKey); // Start scanning for arguments after firstObject.
        while ((eachObject = va_arg(argumentList, id)))
        {
            [strArgument appendFormat:@",%@",eachObject];
        }// As many times as we can get an argument of type "id"
        va_end(argumentList);
    }
    
    NSString *className = NSStringFromClass([self class]);
    
    const char *cClassName = [className UTF8String];
    
    id theClass = objc_getClass(cClassName);
    
    unsigned int propCount, i;
    
    objc_property_t *properties = class_copyPropertyList(theClass, &propCount);
    
    NSMutableArray *propertyNames = [[NSMutableArray alloc] initWithCapacity:1];
    
    for (i = 0; i < propCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyNameString = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [propertyNames addObject:propertyNameString];
    }
    
    NSMutableDictionary *finalDict = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    for(NSString *key in propertyNames)
    {
        SEL selector = NSSelectorFromString(key);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        id value = [self performSelector:selector];
#pragma clang diagnostic pop
        //        if (value == nil){
        //            value = [NSNull null];
        //        }
        BOOL isNotFound = [strArgument rangeOfString:[self getFormat:key]].location == NSNotFound;
        if (value && (isUse ? !isNotFound : isNotFound)) {
            [finalDict setObject:value forKey:key];
        }
    }
    free(properties);
    
    return finalDict;
    return nil;
}

- (NSString*)getFormat:(NSString*)value{
    return [NSString stringWithFormat:@",%@",value];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
//    MLOG(@"super Value:%@,UndefinedKey:%@",value,key);
}

/* 获取对象的所有属性 */
- (NSArray *)getAllProperties
{
    u_int count;
    
    objc_property_t *properties  =class_copyPropertyList([self superclass], &count);
    
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    
    free(properties);
    
    return propertiesArray;
}

//static const char *getPropertyType(objc_property_t property) {
//    const char *attributes = property_getAttributes(property);
//    char buffer[1 + strlen(attributes)];
//    strcpy(buffer, attributes);
//    //fprintf(stdout, "%s", attributes);
//    char *state = buffer, *attribute;
//    while ((attribute = strsep(&state, ",")) != NULL) {
//        if (attribute[0] == 'T') {
//            if(attribute[1] == '@') {
//                return (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
//            } else {
//                return (const char *)[[NSData dataWithBytes:(attribute + 1) length:strlen(attribute) - 1] bytes];
//            }
//        }
//    }
//    return "@";
//}

- (NSString*)customDescription{
    NSMutableString *strDescr = [NSMutableString stringWithFormat:@"%@: ",NSStringFromClass([self class])];
    unsigned int propCount, i;
    objc_property_t* properties = class_copyPropertyList([self class], &propCount);
    for (i = 0; i < propCount; i++) {
        objc_property_t prop = properties[i];
        const char *propName = property_getName(prop);
        if(propName) {
            NSString *name = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
            id obj = [self valueForKey:name];
            if([obj isKindOfClass:[NSString class]]){
                [strDescr appendFormat:@"%@:%@ ",name,[obj replaceUnicodeToChinese]];
            }else{
                [strDescr appendFormat:@"%@:%@ ",name,obj];
            }
        }
    }
    free(properties);
    return strDescr;
}

@end
