//
//  LoginHandler.h
//  RongYun
//
//  Created by 乐米科技 on 5/8/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseHandler.h"

#import "UserEntity.h"

@interface LoginHandler : BaseHandler

/**
 *  用户登录业务逻辑处理
 *
 *  @param user
 *  @param success
 *  @param failed
 */
- (void)executeLoginTaskWithUser:(UserEntity *)user success:(SuccessBlock)success failed:(FailedBlock)failed;

@end
