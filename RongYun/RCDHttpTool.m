//
//  RCDHttpTool.m
//  RCloudMessage
//
//  Created by Liv on 15/4/15.
//  Copyright (c) 2015年 胡利武. All rights reserved.
//

#import "RCDHttpTool.h"
#import "AFHttpTool.h"
#import "RCDGroupInfo.h"
#import "RCDUserInfo.h"
#import "RCDRCIMDataSource.h"
#import "WHHttpClient.h"
#import "APIConfig.h"
#import "UserEntity.h"
@implementation RCDHttpTool

+ (RCDHttpTool*)shareInstance
{
    static RCDHttpTool* instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
        instance.allGroups = [NSMutableArray new];
    });
    return instance;
}

-(void) isMyFriendWithUserInfo:(RCDUserInfo *)userInfo
                  completion:(void(^)(BOOL isFriend)) completion
{
    [self getFriends:^(NSMutableArray *result) {
        for (RCDUserInfo *user in result) {
            if ([user.userId isEqualToString:userInfo.userId] && completion && [@"1" isEqualToString:userInfo.status]) {
                completion(YES);
            }else if(completion){
                completion(NO);
            }
        }
    }];
}
//根据id获取单个群组
-(void) getGroupByID:(NSString *) groupID
   successCompletion:(void (^)(RCGroup *group)) completion
{
    [AFHttpTool getAllGroupsSuccess:^(id response) {
        NSArray *allGroups = response[@"result"];
        if (allGroups) {
            for (NSDictionary *dic in allGroups) {
                RCGroup *group = [[RCGroup alloc] init];
                group.groupId = [dic objectForKey:@"id"];
                group.groupName = [dic objectForKey:@"name"];
                group.portraitUri = (NSNull *)[dic objectForKey:@"portrait"] == [NSNull null] ? nil: [dic objectForKey:@"portrait"];
                
                if ([group.groupId isEqualToString:groupID] && completion) {
                    completion(group);
                }
            }

        }
        
    } failure:^(NSError* err){
        
    }];}

-(RCUserInfo *) getUserInfoByUserID:(NSString *) userID
                         completion:(void (^)(RCUserInfo *user)) completion
{
    [AFHttpTool getFriendsSuccess:^(id response) {
        if (response) {
            NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];

            if ([code isEqualToString:@"200"]) {

                NSArray * regDataArray = response[@"result"];
                
                for(int i = 0;i < regDataArray.count;i++){

                    NSDictionary *dic = [regDataArray objectAtIndex:i];
                    if ([userID isEqualToString:[dic objectForKey:@"id"]]) {
                        RCUserInfo *userInfo = [RCUserInfo new];
                        NSNumber *idNum = [dic objectForKey:@"id"];
                        userInfo.userId = [NSString stringWithFormat:@"%d",idNum.intValue];
                        userInfo.portraitUri = [dic objectForKey:@"portrait"];
                        userInfo.name = [dic objectForKey:@"username"];
                        if (completion) {
                            completion(userInfo);
                        }
                    }


                }
                
                
            }
            
        }

    } failure:^(NSError *err) {
        
    }];
    return nil;
}

- (void)getAllGroupsWithCompletion:(void (^)(NSMutableArray* result))completion
{


    [AFHttpTool getAllGroupsSuccess:^(id response) {
        NSMutableArray *tempArr = [NSMutableArray new];
        NSArray *allGroups = response[@"result"];
        if (allGroups) {
            for (NSDictionary *dic in allGroups) {
                RCDGroupInfo *group = [[RCDGroupInfo alloc] init];
                group.groupId = [dic objectForKey:@"id"];
                group.groupName = [dic objectForKey:@"name"];
                group.portraitUri = [dic objectForKey:@"portrait"];
                if (group.portraitUri) {
                    group.portraitUri=@"";
                }
                group.creatorId = [dic objectForKey:@"create_user_id"];
                group.introduce = [dic objectForKey:@"introduce"];
                if (group.introduce) {
                    group.introduce=@"";
                }
                group.number = [dic objectForKey:@"number"];
                group.maxNumber = [dic objectForKey:@"max_number"];
                group.creatorTime = [dic objectForKey:@"creat_datetime"];
                [tempArr addObject:group];
            }
            
            //获取加入状态
            [self getMyGroupsWithBlock:^(NSMutableArray *result) {
                for (RCDGroupInfo *group in result) {
                    for (RCDGroupInfo *groupInfo in tempArr) {
                        if ([group.groupId isEqualToString:groupInfo.groupId]) {
                            groupInfo.isJoin = YES;
                        }
                    }
                }
                if (completion) {
                    completion(tempArr);
                }

            }];

            
        }

    } failure:^(NSError* err){

    }];
}


-(void) getMyGroupsWithBlock:(void(^)(NSMutableArray* result)) block
{
    [AFHttpTool getMyGroupsSuccess:^(id response) {
        NSArray *allGroups = response[@"result"];
        NSMutableArray *tempArr = [NSMutableArray new];
        if (allGroups) {
            for (NSDictionary *dic in allGroups) {
                RCDGroupInfo *group = [[RCDGroupInfo alloc] init];
                group.groupId = [dic objectForKey:@"id"];
                group.groupName = [dic objectForKey:@"name"];
                group.portraitUri = [dic objectForKey:@"portrait"];
                if (group.portraitUri) {
                    group.portraitUri=@"";
                }
                group.creatorId = [dic objectForKey:@"create_user_id"];
                group.introduce = [dic objectForKey:@"introduce"];
                if (group.introduce) {
                    group.introduce=@"";
                }
                group.number = [dic objectForKey:@"number"];
                group.maxNumber = [dic objectForKey:@"max_number"];
                group.creatorTime = [dic objectForKey:@"creat_datetime"];
                [tempArr addObject:group];
            }
            
            if (block) {
                block(tempArr);
            }
        }

    } failure:^(NSError *err) {
        
    }];
}

- (void)joinGroup:(int)groupID complete:(void (^)(BOOL))joinResult
{
    [AFHttpTool joinGroupByID:groupID success:^(id response) {
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        if (joinResult) {
            if ([code isEqualToString:@"200"]) {
                                
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    joinResult(YES);
                });
                
            }else{
                joinResult(NO);
            }
            
        }
    } failure:^(id response) {
        if (joinResult) {
            joinResult(NO);
        }
    }];
}

- (void)quitGroup:(int)groupID complete:(void (^)(BOOL))result
{
    [AFHttpTool quitGroupByID:groupID success:^(id response) {
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        
        if (result) {
            if ([code isEqualToString:@"200"]) {
                result(YES);
            }else{
                result(NO);
            }
            
        }
    } failure:^(id response) {
        if (result) {
            result(NO);
        }
    }];
}

- (void)updateGroupById:(int)groupID withGroupName:(NSString*)groupName andintroduce:(NSString*)introduce complete:(void (^)(BOOL))result

{
    __block typeof(id) weakGroupId = [NSString stringWithFormat:@"%d", groupID];
    [AFHttpTool updateGroupByID:groupID withGroupName:groupName andGroupIntroduce:introduce success:^(id response) {
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        
        if (result) {
            if ([code isEqualToString:@"200"]) {
                
                for (RCDGroupInfo *group in _allGroups) {
                    if ([group.groupId isEqualToString:weakGroupId]) {
                        group.groupName=groupName;
                        group.introduce=introduce;
                    }
                    
                }
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    result(YES);
                });
                
            }else{
                result(NO);
            }
            
        }
    } failure:^(id response) {
        if (result) {
            result(NO);
        }
    }];
}

- (void)getFriends:(void (^)(NSMutableArray*))friendList
{
    NSMutableArray* list = [NSMutableArray new];
    
    WHHttpClient *http = [WHHttpClient defaultClient];
    UserEntity *user = [UserEntity sharedUserEntity];
    NSDictionary *dic = @{@"otype":@"getc",@"f_type":@"-1",@"u_id":user.u_id};
    [http requestWithPath:URL_USER_LOGIN method:RTHttpRequestGet parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id response) {
        
        if (friendList)
        {
                [_allFriends removeAllObjects];
                NSArray * regDataArray = response;
                
                for(int i = 0;i < regDataArray.count;i++){
                    
                    NSDictionary *dic = [regDataArray objectAtIndex:i];
                    RCDUserInfo*userInfo = [[RCDUserInfo alloc]initWithDict:dic];;
                    [list addObject:userInfo];
                    [_allFriends addObject:userInfo];
                }
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    friendList(list);
                });
                
            }
        

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (friendList) {
            friendList(list);
        }

    }];
    return;
    [AFHttpTool getFriendListFromServerSuccess:^(id response) {
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        
        if (friendList) {
            if ([code isEqualToString:@"200"]) {
                [_allFriends removeAllObjects];
                NSArray * regDataArray = response[@"result"];
                
                for(int i = 0;i < regDataArray.count;i++){
                    
                    NSDictionary *dic = [regDataArray objectAtIndex:i];
                    RCDUserInfo*userInfo = [RCDUserInfo new];
                    NSNumber *idNum = [dic objectForKey:@"id"];
                    userInfo.userId = [NSString stringWithFormat:@"%d",idNum.intValue];
                    userInfo.portraitUri = [dic objectForKey:@"portrait"];
                    userInfo.userName = [dic objectForKey:@"username"];
                    userInfo.email = [dic objectForKey:@"email"];
                    userInfo.status = [dic objectForKey:@"status"];
                    [list addObject:userInfo];
                    [_allFriends addObject:userInfo];
                }
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    friendList(list);
                });
                
            }else{
                friendList(list);
            }
            
        }
    } failure:^(id response) {
        if (friendList) {
            friendList(list);
        }
    }];
}

- (void)searchFriendListByEmail:(NSString*)email complete:(void (^)(NSMutableArray*))friendList
{
    NSMutableArray* list = [NSMutableArray new];
    [AFHttpTool searchFriendListByEmail:email success:^(id response) {
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        
        if (friendList) {
            if ([code isEqualToString:@"200"]) {
                
                NSArray * regDataArray = response[@"result"];
                for(int i = 0;i < regDataArray.count;i++){
                    
                    NSDictionary *dic = [regDataArray objectAtIndex:i];
                    RCDUserInfo*userInfo = [RCDUserInfo new];
                    NSNumber *idNum = [dic objectForKey:@"id"];
                    userInfo.userId = [NSString stringWithFormat:@"%d",idNum.intValue];
                    userInfo.portraitUri = [dic objectForKey:@"portrait"];
                    userInfo.userName = [dic objectForKey:@"username"];
                    [list addObject:userInfo];
                }
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    friendList(list);
                });
                
            }else{
                friendList(list);
            }
            
        }
    } failure:^(id response) {
        if (friendList) {
            friendList(list);
        }
    }];
}

- (void)searchFriendListByName:(NSString*)name complete:(void (^)(NSMutableArray*))friendList
{
    NSMutableArray* list = [NSMutableArray new];
    [AFHttpTool searchFriendListByName:name success:^(id response) {
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        
        if (friendList) {
            if ([code isEqualToString:@"200"]) {
                
                NSArray * regDataArray = response[@"result"];
                for(int i = 0;i < regDataArray.count;i++){
                    
                    NSDictionary *dic = [regDataArray objectAtIndex:i];
                    RCDUserInfo*userInfo = [RCDUserInfo new];
                    NSNumber *idNum = [dic objectForKey:@"id"];
                    userInfo.userId = [NSString stringWithFormat:@"%d",idNum.intValue];
                    userInfo.portraitUri = [dic objectForKey:@"portrait"];
                    userInfo.userName = [dic objectForKey:@"username"];
                    [list addObject:userInfo];
                }
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    friendList(list);
                });
                
            }else{
                friendList(list);
            }
            
        }
    } failure:^(id response) {
        if (friendList) {
            friendList(list);
        }
    }];
}
- (void)requestFriend:(NSString*)userId complete:(void (^)(BOOL))result
{
    [AFHttpTool requestFriend:userId success:^(id response) {
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        
        if (result) {
            if ([code isEqualToString:@"200"]) {
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    result(YES);
                });
                
            }else{
                result(NO);
            }
            
        }
    } failure:^(id response) {
        if (result) {
            result(NO);
        }
    }];
}
- (void)processRequestFriend:(NSString*)userId withIsAccess:(BOOL)isAccess complete:(void (^)(BOOL))result
{
    [AFHttpTool processRequestFriend:userId withIsAccess:isAccess success:^(id response) {
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        
        if (result) {
            if ([code isEqualToString:@"200"]) {
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    result(YES);
                });
                
            }else{
                result(NO);
            }
        }
    } failure:^(id response) {
        if (result) {
            result(NO);
        }
    }];
}

- (void)deleteFriend:(NSString*)userId complete:(void (^)(BOOL))result
{
    [AFHttpTool deleteFriend:userId success:^(id response) {
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        
        if (result) {
            if ([code isEqualToString:@"200"]) {
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    result(YES);
                });
                
            }else{
                result(NO);
            }
            
        }
    } failure:^(id response) {
        if (result) {
            result(NO);
        }
    }];
}

@end
