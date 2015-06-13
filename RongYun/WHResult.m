//
//  WHResult.m
//  RongYun
//
//  Created by 乐米科技 on 5/9/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "WHResult.h"

@implementation WHResult

- (BOOL)isSuccess{
    return (_code == 0 && _flag == 0);
}

- (NSString*)getErrorMessage{
    if (![StrUtils isEmpty:_message]) {
        return _message;
    }
    return _message;
}

- (NSString *)message
{
    if (![StrUtils isEmpty:_message]) {
        return _message;
    } else if (![StrUtils isEmpty:_errorInfo]) {
        return _errorInfo;
    }
    return nil;
}
@end
