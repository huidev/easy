//
//  WHResult.h
//  RongYun
//
//  Created by 乐米科技 on 5/9/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+ModelAdditions.h"

typedef enum ResultCode {
    ResultCode_Success           = 0,
    ResultCode_SystemException   = -1,
    ResultCode_PermissionLimited = -2,
    ResultCode_ParamsException   = -3,
    ResultCode_VersionException  = -4,
    ResultCode_HospitalIDErr     = -5,
    ResultCode_TokenValid        = -6,
    ResultCode_LinkErr           = -98,
    ResultCode_SystemMaintenance = -99,
    ResultCode_NetworkException  = -8888,
    ResultCode_OperationCancel   = -9999
}Resultcode;

@interface WHResult : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, strong) NSString* message;
@property (nonatomic, strong) NSString* errorInfo;

@property (nonatomic, strong) id responseObject;

- (BOOL)isSuccess;
- (NSString*)getErrorMessage;
@end
