//
//  ChatViewController.m
//  RongYun
//
//  Created by 乐米科技 on 5/9/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "ChatViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "KxMenu.h"
#import "RCDAddressBookViewController.h"
#import "RCDSearchFriendViewController.h"
#import "RCDSelectPersonViewController.h"
#import "RCDRCIMDataSource.h"
#import "RCDAddFriendTableViewController.h"
#import "RCDChatViewController.h"
#import "RCConversationListViewController.h"
#import "RCDChatListCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "AFHttpTool.h"
#import "CommInfo.h"
#import "RCDUserInfo.h"
#import "RCDLoginInfo.h"
@implementation ChatViewController

/**
 *  此处使用storyboard初始化，代码初始化当前类时*****必须要设置会话类型和聚合类型*****
 *
 *  @param aDecoder aDecoder description
 *
 *  @return return value description
 */
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self =[super initWithCoder:aDecoder];
    if (self) {
        //设置要显示的会话类型
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION), @(ConversationType_APPSERVICE), @(ConversationType_PUBLICSERVICE),@(ConversationType_GROUP)]];
        
        //聚合会话类型
        //        [self setCollectionConversationType:@[@(ConversationType_PRIVATE)]];
        
        //设置为不用默认渲染方式
        self.tabBarItem.image = [[UIImage imageNamed:@"icon_chat"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_chat_hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        _myDataSource = [NSMutableArray new];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tableView样式
    self.conversationListTableView.separatorColor = UIColorFromRGB(0xdfdfdf);
    self.conversationListTableView.tableFooterView = [UIView new];
    self.conversationListTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 12)];
    
//    [self loginRongCould];
    [self setRightBarButtonItemWithText:nil imageName:@"navigator_btn_add1"];
}

- (void)barButtonItemAction:(UIButton *)sender
{
//    [self pushChat:sender];
    [self pushAddressBook:sender];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateBadgeValueForTabBarItem];
    
}
- (void)loginRongCould
{
    NSString *_deviceTokenCache = [[NSUserDefaults standardUserDefaults]objectForKey:kDeviceToken];
    
    //设置会话列表头像和会话界面头像
    [RCIM sharedKit].globalConversationPortraitSize = CGSizeMake(56, 56);
    [RCIM sharedKit].globalMessagePortraitSize = CGSizeMake(40, 40);
    //登陆融云服务器
    //token +hfEluLjZ78E1qo4hGRHcB01HLt4Xz13cunU1j3NdXlWsFs8Ixd36PRAul3lg==
    UserEntity *user = [UserEntity sharedUserEntity];
    [[RCIM sharedKit] initWithAppKey:RONGCLOUD_IM_APPKEY deviceToken:_deviceTokenCache];
    [[RCIM sharedKit] connectWithToken:@"Cuq8+lXiZiHRE/pkNl1tr82yq+hfEluLjZ78E1qo4hGRHcB01HLt4Yu/rwmRU8jZUxnRD8LI7HVd36PRAul3lg==" success:^(NSString *userId) {
        //保存默认用户
        //                                           [DEFAULTS setObject:userName forKey:@"userName"];
        //                                           [DEFAULTS setObject:password forKey:@"userPwd"];
        //                                           [DEFAULTS setObject:token forKey:@"userToken"];
        //                                           [DEFAULTS setObject:userId forKey:@"userId"];
        //                                           [DEFAULTS synchronize];
        
        //设置当前的用户信息
        RCUserInfo *_currentUserInfo = [[RCUserInfo alloc]initWithUserId:userId name:user.u_name portrait:nil];
        [RCIMClient sharedClient].currentUserInfo = _currentUserInfo;
        //同步群组
        [RCDDataSource syncGroups];
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });

    } error:^(RCConnectErrorCode status) {
        // [hud setHidden:YES];
        NSLog(@"RCConnectErrorCode is %ld",(long)status);
    }];
    return;
//    NSString *userName = [CommInfo loginUserName];
//    NSString *password = [CommInfo getPassword];
//    if ([self validateUserName:userName userPwd:password]) {
//        [AFHttpTool loginWithEmail:@"553951696@qq.com" password:@"123456"
//                           success:^(id response) {
//
//                               if ([response[@"code"] intValue] == 200) {
//                                   RCDLoginInfo *loginInfo = [RCDLoginInfo shareLoginInfo];
//                                   loginInfo = [loginInfo initWithDict:response[@"result"]];
//                                   
//                                   [AFHttpTool getTokenSuccess:^(id response) {
//                                       
//                                       NSString *token = response[@"result"][@"token"];
//                                       //登陆融云服务器
//                                       [[RCIM sharedKit] connectWithToken:token success:^(NSString *userId) {
//                                           //保存默认用户
////                                           [DEFAULTS setObject:userName forKey:@"userName"];
////                                           [DEFAULTS setObject:password forKey:@"userPwd"];
////                                           [DEFAULTS setObject:token forKey:@"userToken"];
////                                           [DEFAULTS setObject:userId forKey:@"userId"];
////                                           [DEFAULTS synchronize];
//                                           
//                                           //设置当前的用户信息
//                                           RCUserInfo *_currentUserInfo = [[RCUserInfo alloc]initWithUserId:userId name:userName portrait:nil];
//                                           [RCIMClient sharedClient].currentUserInfo = _currentUserInfo;
//                                           
//                                           //同步群组
//                                           [RCDDataSource syncGroups];
//                                           
//                                           dispatch_async(dispatch_get_main_queue(), ^{
////                                               UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
////                                               UINavigationController *rootNavi = [storyboard instantiateViewControllerWithIdentifier:@"rootNavi"];
////                                               [ShareApplicationDelegate window].rootViewController = rootNavi;
//                                               
//                                           });
//                                           
//                                           
//                                       } error:^(RCConnectErrorCode status) {
//                                           // [hud setHidden:YES];
//                                           NSLog(@"RCConnectErrorCode is %ld",(long)status);
//                                       }];
//                                       
//                                       
//                                       
//                                       
//                                   } failure:^(NSError *err) {
//                                       
//                                   }];
//                               }else{
//                                   //关闭HUD
//                                   
//                                   int _errCode = [response[@"code"] intValue];
//                                   NSLog(@"NSError is %d",_errCode);
//                                   
//                                   
//                               }
//                               
//                           }
//                           failure:^(NSError* err) {
//                               //关闭HUD
//                               
//                               NSLog(@"NSError is %ld",(long)err.code);
//                               if (err.code == 3840) {
////                                   _errorMsgLb.text=@"用户名或密码错误！";
////                                   [_pwdTextField shake];
//                               }
//                               
//                           }];

//}
}
- (BOOL)validateUserName:(NSString*)userName userPwd:(NSString*)userPwd
{
    NSString* alertMessage = nil;
    if (userName.length == 0) {
        alertMessage = @"用户名不能为空!";
    }
    else if (userPwd.length == 0) {
        alertMessage = @"密码不能为空!";
    }
    
    if (alertMessage) {
        
        return NO;
    }
    return YES;
}

- (void)updateBadgeValueForTabBarItem
{
    __weak typeof(self) __weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        int count = [[RCIMClient sharedClient]getUnreadCount:self.displayConversationTypeArray];
        if (count>0) {
            __weakSelf.tabBarItem.badgeValue = [[NSString alloc]initWithFormat:@"%d",count];
        }else
        {
            __weakSelf.tabBarItem.badgeValue = nil;
        }
        
    });
}

/**
 *  点击进入会话界面
 *
 *  @param conversationModelType 会话类型
 *  @param model                 会话数据
 *  @param indexPath             indexPath description
 */
-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    if (conversationModelType == ConversationModelType_Normal) {
        RCDChatViewController *_conversationVC = [[RCDChatViewController alloc]init];
        _conversationVC.conversationType = model.conversationType;
        _conversationVC.targetId = model.targetId;
        _conversationVC.targetName = model.conversationTitle;
        _conversationVC.title = model.conversationTitle;
        _conversationVC.conversation = model;
        
        _conversationVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:_conversationVC animated:YES];
    }
    
    //聚合会话类型，此处自定设置。
    //    if (conversationModelType == ConversationModelType_Collection) {
    //
    //        RCDChatListViewController *temp = [[RCDChatListViewController alloc] init];
    //        NSArray *array = [NSArray arrayWithObject:[NSNumber numberWithInt:model.conversationType]];
    //        [temp setDisplayConversationTypes:array];
    //        [temp setCollectionConversationType:nil];
    //        [self.navigationController pushViewController:temp animated:YES];
    //    }
    
    //自定义会话类型
    if (conversationModelType == ConversationModelType_UserCustom) {
        RCConversationModel *model = self.conversationListaDataSource[indexPath.row];
        //RCUserInfo *user = (RCUserInfo *)model.extend;
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RCDAddFriendTableViewController *temp = [mainStoryboard instantiateViewControllerWithIdentifier:@"RCDAddFriendTableViewController"];
        temp.userInfo = model.extend;
        [self.navigationController pushViewController:temp animated:YES];
    }
    
}

/**
 *  弹出层
 *
 *  @param sender sender description
 */
- (IBAction)showMenu:(UIButton *)sender {
    NSArray *menuItems =
    @[
      
      [KxMenuItem menuItem:@"发起聊天"
                     image:[UIImage imageNamed:@"chat_icon"]
                    target:self
                    action:@selector(pushChat:)],
      
      [KxMenuItem menuItem:@"添加好友"
                     image:[UIImage imageNamed:@"addfriend_icon"]
                    target:self
                    action:@selector(pushAddFriend:)],
      
      [KxMenuItem menuItem:@"添加公众号"
                     image:[UIImage imageNamed:@"addfriend_icon"]
                    target:self
                    action:@selector(pushAddPublicService:)],
      
      [KxMenuItem menuItem:@"通讯录"
                     image:[UIImage imageNamed:@"contact_icon"]
                    target:self
                    action:@selector(pushAddressBook:)],
      
      [KxMenuItem menuItem:@"公众账号"
                     image:[UIImage imageNamed:@"contact_icon"]
                    target:self
                    action:@selector(pushPublicService:)],
      ];
    
    CGRect targetFrame = self.tabBarController.navigationItem.rightBarButtonItem.customView.frame;
    targetFrame.origin.y = targetFrame.origin.y + 15;
    [KxMenu showMenuInView:self.tabBarController.navigationController.navigationBar.superview
                  fromRect:targetFrame
                 menuItems:menuItems];
}


/**
 *  发起聊天
 *
 *  @param sender sender description
 */
- (void) pushChat:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RCDSelectPersonViewController *selectPersonVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"RCDSelectPersonViewController"];
    
    //设置点击确定之后回传被选择联系人操作
    __weak typeof(&*self)  weakSelf = self;
    selectPersonVC.clickDoneCompletion = ^(RCDSelectPersonViewController *selectPersonViewController,NSArray *selectedUsers){
        if(selectedUsers.count == 1)
        {
            RCUserInfo *user = selectedUsers[0];
            RCDChatViewController *chat =[[RCDChatViewController alloc]init];
            chat.targetId                      = user.userId;
            chat.targetName                    = user.name;
            chat.conversationType              = ConversationType_PRIVATE;
            chat.title                         = user.name;
            
            //跳转到会话页面
            dispatch_async(dispatch_get_main_queue(), ^{
                UITabBarController *tabbarVC = weakSelf.navigationController.viewControllers[0];
                [weakSelf.navigationController popToViewController:tabbarVC animated:YES];
                [tabbarVC.navigationController  pushViewController:chat animated:YES];
            });
            
        }
        //选择多人则创建讨论组
        else if(selectedUsers.count > 1)
        {
            
            NSString *discussionTitle = @"";
            NSMutableArray *userIdList = [NSMutableArray new];
            for (RCUserInfo *user in selectedUsers) {
                discussionTitle = user.name;
                discussionTitle = [discussionTitle stringByAppendingString:[NSString stringWithFormat:@",%@",user.name]];
                [userIdList addObject:user.userId];
            }
            
            [[RCIMClient sharedClient] createDiscussion:discussionTitle userIdList:userIdList completion:^(RCDiscussion *discussion) {
                NSLog(@"create discussion ssucceed!");
                dispatch_async(dispatch_get_main_queue(), ^{
                    RCDChatViewController *chat =[[RCDChatViewController alloc]init];
                    chat.targetId                      = discussion.discussionId;
                    chat.targetName                    = discussion.discussionName;
                    chat.conversationType              = ConversationType_DISCUSSION;
                    chat.title                         = @"讨论组";
                    
                    
                    UITabBarController *tabbarVC = weakSelf.navigationController.viewControllers[0];
                    [weakSelf.navigationController popToViewController:tabbarVC animated:YES];
                    [tabbarVC.navigationController  pushViewController:chat animated:YES];
                });
            } error:^(RCErrorCode status) {
                NSLog(@"create discussion Failed > %ld!", (long)status);
            }];
            return;
        }
    };
    
    [self.navigationController showViewController:selectPersonVC sender:self.navigationController];
}

/**
 *  公众号会话
 *
 *  @param sender sender description
 */
- (void) pushPublicService:(id) sender
{
    RCPublicServiceListViewController *publicServiceVC = [[RCPublicServiceListViewController alloc] init];
    [self.navigationController pushViewController:publicServiceVC  animated:YES];
    
}


/**
 *  添加好友
 *
 *  @param sender sender description
 */
- (void) pushAddFriend:(id) sender
{
    RCDSearchFriendViewController *searchFirendVC = [RCDSearchFriendViewController searchFriendViewController];
    [self.navigationController pushViewController:searchFirendVC  animated:YES];
    
}

/**
 *  通讯录
 *
 *  @param sender sender description
 */
-(void) pushAddressBook:(id) sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RCDAddressBookViewController *addressBookVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"RCDAddressBookViewController"];
    addressBookVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addressBookVC animated:YES];
    
}

/**
 *  添加公众号
 *
 *  @param sender sender description
 */
- (void) pushAddPublicService:(id) sender
{
    RCPublicServiceSearchViewController *searchFirendVC = [[RCPublicServiceSearchViewController alloc] init];
    [self.navigationController pushViewController:searchFirendVC  animated:YES];
    
}


//*********************插入自定义Cell*********************//

//插入自定义会话model
-(NSMutableArray *)willReloadTableData:(NSMutableArray *)dataSource
{
    
    for (int i=0; i<_myDataSource.count; i++) {
        RCConversationModel *customModel =[_myDataSource objectAtIndex:i];
        [dataSource insertObject:customModel atIndex:0];
    }
    
    return dataSource;
}

//左滑删除
-(void)rcConversationListTableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RCConversationModel *model = self.conversationListaDataSource[indexPath.row];
    [_myDataSource removeObject:model];
    [self.conversationListaDataSource removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

//高度
-(CGFloat)rcConversationListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.f;
}

//自定义cell
-(RCConversationBaseCell *)rcConversationListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RCConversationModel *model = self.conversationListaDataSource[indexPath.row];
    RCDUserInfo *user = (RCDUserInfo *)model.extend;
    RCDChatListCell *cell = [[RCDChatListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    cell.lblDetail.text =[NSString stringWithFormat:@"来自\"%@\"的好友请求",user.userName];
//    [cell.ivAva sd_setImageWithURL:[NSURL URLWithString:user.portraitUri] placeholderImage:[UIImage imageNamed:@"default_portrait"]];
    [cell.ivAva setImageWithURL:[NSURL URLWithString:user.portraitUri] placeholderImage:[UIImage imageNamed:@"default_portrait"]];
    return cell;
}

//*********************插入自定义Cell*********************//


#pragma mark - 收到消息监听
-(void)didReceiveMessageNotification:(NSNotification *)notification
{
    
    //处理好友请求
    RCMessage *message = notification.object;
    if ([message.content isMemberOfClass:[RCContactNotificationMessage class]]) {
//        [RCDHTTPTOOL getFriends:^(NSMutableArray *result) {
//            if (result) {
//                NSUInteger _count = [result count];
//                for (NSUInteger i=0; i<_count; i++) {
//                    RCDUserInfo *userinfo = result[i];
//                    NSString *_status = userinfo.status;
//                    NSLog(@"%@", _status);
//                    if([@"3" isEqualToString:_status])
//                    {
//                        //请求被添加
//                        // RCUserInfo *userinfo_model = [[RCUserInfo alloc]initWithUserId:userinfo.userId name:userinfo.userName portrait:userinfo.portraitUri];
//                        
//                        RCConversationModel *customModel = [RCConversationModel new];
//                        customModel.conversationModelType = ConversationModelType_UserCustom;
//                        customModel.extend = userinfo;
//                        customModel.senderUserId = message.senderUserId;
//                        [_myDataSource insertObject:customModel atIndex:0];
//                        
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            //调用父类刷新未读消息数
//                            [super didReceiveMessageNotification:notification];
//                            
//                            [self updateBadgeValueForTabBarItem];
//                        });
//                        
//                    }else if([@"2" isEqualToString:_status]){
//                        //请求被添加
//                    }else if ([@"4" isEqualToString:_status]){
//                        //请求被拒绝
//                    }else if ([@"5" isEqualToString:_status]){
//                        //我被对方删除
//                    }
//                }
//            }
//        }];
        
        //        [RCDHTTPTOOL getUserInfoByUserID:message.senderUserId
        //                              completion:^(RCUserInfo *user) {
        //
        //            RCConversationModel *customModel = [RCConversationModel new];
        //            customModel.conversationModelType = ConversationModelType_UserCustom;
        //            customModel.extend = user;
        //            customModel.senderUserId = message.senderUserId;
        //            [_myDataSource insertObject:customModel atIndex:0];
        //        }];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            //调用父类刷新未读消息数
            [super didReceiveMessageNotification:notification];
            
            [self updateBadgeValueForTabBarItem];
        });
    }
}

@end
