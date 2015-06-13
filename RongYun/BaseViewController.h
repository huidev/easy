//
//  BaseViewController.h
//  RongYun
//
//  Created by 于君 on 15/5/7.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UIViewController+Customize.h"
#import <AFNetworking/AFNetworking.h>
#import "APIConfig.h"
#import <FMDB/FMDB.h>
#import "WHHttpClient.h"
#import "BaseHandler.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "WHJSONResponseSerializerWithData.h"
#import "PullTableView.h"
#import "UserEntity.h"
//leon.begin
typedef NS_ENUM(NSInteger, WYViewLifeCircleState){
    WYViewLifeCircleState_UnKnown       = -1,
    WYViewLifeCircleState_DidLoad       = 0,
    WYViewLifeCircleState_WillAppear    = 1,
    WYViewLifeCircleState_DidAppear     = 2,
    WYViewLifeCircleState_WillDisappear = 3,
    WYViewLifeCircleState_DidDisappear  = 4,
};

@interface BaseViewController : UIViewController<UIGestureRecognizerDelegate>

@property (assign, nonatomic, readonly) WYViewLifeCircleState lifeState;
@property (assign, nonatomic) BOOL  isNeedRefreshUI;
@property (nonatomic, strong)NSMutableArray *dataArray;

@property (strong, nonatomic) WHHttpClient *httpRequest;
@property (strong, nonatomic) SVProgressHUD *hudView;
@property (strong, nonatomic) UIView *errorView;

+ (instancetype)viewControllerWithNibIndex:(NSInteger)index;
- (void)setLeftBarButtonItemWithText:(NSString *)text imageName:(NSString *)image respond:(void(^)(UIBarButtonItem *leftItem))action;
- (void)setRightBarButtonItemWithText:(NSString *)text imageName:(NSString *)image;
- (void)barButtonItemAction:(UIBarButtonItem *)barItem;
- (void)setNavigationBarAppearance:(BOOL)isDefaultBlue;
- (void)showAlertView:(NSString*)msg;
- (void)allocData;
- (void)configSubviews;
- (void)requestData;
- (void)tapErrorAction:(UITapGestureRecognizer *)gesture;
/**
 *  HTTP请求（GET、POST、DELETE、PUT）
 *
 *  @param path
 *  @param method     RESTFul请求类型
 *  @param parameters 请求参数
 *  @param prepare    请求前预处理块
 *  @param success    请求成功处理块
 *  @param failure    请求失败处理块
 */
- (void)requestPostWithRelativeUrl:(NSString *)url
                        parameters:(NSDictionary *)dic
                    prepareExecute:(PrepareExecuteBlock) prepare
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)requestGetWithRelativeUrl:(NSString *)url
                       parameters:(NSDictionary *)dic
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


@end
