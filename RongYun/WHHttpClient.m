//
//  WHHttpClient.m
//  RongYun
//
//  Created by 乐米科技 on 5/8/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "WHHttpClient.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "APIConfig.h"
#import "Reachability.h"//pod 'Reachability', '~> 3.1.1'
#import "WHJSONResponseSerializerWithData.h"

@interface WHHttpClient()
@property(nonatomic,strong) AFHTTPSessionManager *manager;
@end

@implementation WHHttpClient

- (id)init{
    if (self = [super init]){
        self.manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:SERVER_HOST] sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        //请求参数序列化类型
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //响应结果序列化类型
//        self.manager.responseSerializer = [WHJSONResponseSerializerWithData serializer];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    }
    return self;
}

+ (WHHttpClient *)defaultClient
{
    static WHHttpClient *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


- (void)requestWithPath:(NSString *)url
                 method:(NSInteger)method
             parameters:(id)parameters prepareExecute:(PrepareExecuteBlock)prepareExecute
                success:(void (^)(NSURLSessionDataTask *, id))success
                failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    //请求的URL
    DLog(@"Request path:%@",url);
    
    //判断网络状况（有链接：执行请求；无链接：弹出提示）
    if ([self isConnectionAvailable]) {
        //预处理（显示加载信息啥的）
        if (prepareExecute) {
            prepareExecute();
        }
        switch (method) {
            case RTHttpRequestGet:
            {
                [self.manager GET:url parameters:parameters success:success failure:failure];
            }
                break;
            case RTHttpRequestPost:
            {
                [self.manager POST:url parameters:parameters success:success failure:failure];
            }
                break;
            case RTHttpRequestDelete:
            {
                [self.manager DELETE:url parameters:parameters success:success failure:failure];
            }
                break;
            case RTHttpRequestPut:
            {
                [self.manager PUT:url parameters:parameters success:success failure:false];
            }
                break;
            default:
                break;
        }
    }else{
        //网络错误咯
        [self showExceptionDialog];
        //发出网络异常通知广播
        [[NSNotificationCenter defaultCenter] postNotificationName:@"k_NOTI_NETWORK_ERROR" object:nil];
    }
    
}

- (void)requestWithPathInHEAD:(NSString *)url
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    if ([self isConnectionAvailable]) {
        [self.manager HEAD:url parameters:parameters success:success failure:failure];
    }else{
        [self showExceptionDialog];
    }
}

//看看网络是不是给力
- (BOOL)isConnectionAvailable{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        DLog(@"Error. Could not recover network reachability flags");
        return NO;
    }
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

//弹出网络错误提示框
- (void)showExceptionDialog
{
    [[[UIAlertView alloc] initWithTitle:@"提示"
                                message:@"网络异常，请检查网络连接"
                               delegate:self
                      cancelButtonTitle:@"好的"
                      otherButtonTitles:nil, nil] show];
}

@end