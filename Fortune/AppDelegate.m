//
//  AppDelegate.m
//  Fortune
//
//  Created by Sj03 on 2017/11/20.
//  Copyright © 2017年 Sj03. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabViewController.h"
#import "LoginViewController.h"
#import "CommandTool.h"
#import "HZLaunchImageViewController.h"

#import "GDTSplashAd.h"
#import "GDTSDKConfig.h"

// 引入JPush功能所需头文件
#import <JPUSHService.h>
#import <UserNotifications/UserNotifications.h>

#import <AlipaySDK/AlipaySDK.h>

//微信SDK头文件
#import "WXApi.h"

#define AppId @"wxf20b358db1dd7c6c"


@interface AppDelegate ()<JPUSHRegisterDelegate,GDTSplashAdDelegate,WXApiDelegate>
@property (strong, nonatomic) GDTSplashAd *splash;
@property (retain, nonatomic) UIView *bottomView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [WXApi registerApp:AppId];
    //初始化友盟sdk
    [self initUMSDK];
    
    [self initWindowWithOptions:launchOptions];
    
    [self initJpushSDKWithOptions:launchOptions];
    
    return YES;
}

-(void)initUMSDK {
    [UMConfigure initWithAppkey:kUMAppKey channel:nil];
    // 统计组件配置
    [MobClick setScenarioType:E_UM_NORMAL];
    //发布需要移除
//  [UMConfigure setEncryptEnabled:YES];
    
    [UMConfigure setLogEnabled:YES];
}

#pragma mark 界面初始化
- (void)initWindowWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    HZLaunchImageViewController *launchVC = [[HZLaunchImageViewController alloc] initWithDefaultImage];
    self.window.rootViewController = launchVC;
    [self.window makeKeyAndVisible];
    RACSubject *subject_init = [[RACSubject alloc] init];
    CommandTool *command = [[CommandTool alloc] init];
    
    [[[[subject_init  flattenMap:^RACStream *(id value) {
           // App更新
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            if ([UserDefaultsTool getBoolWithKey:isFirstLogin]) {
                [[command.command_haveNewVersion.executionSignals switchToLatest] subscribeNext:^(id x) {
                    [subscriber sendNext:@YES];
                    [subscriber sendCompleted];
                }];
                
                [command.command_haveNewVersion.errors subscribeNext:^(id x) {
                    [subscriber sendNext:@YES];
                    [subscriber sendCompleted];
                }];
                [command.command_haveNewVersion execute:@YES];
            } else {
                [subscriber sendNext:@YES];
                [subscriber sendCompleted];
            }
            return nil;
        }];
        
    }] flattenMap:^RACStream *(id value) {
        // APP 广告页面
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {

            
//                HZLaunchImageViewController *launchVC = [[HZLaunchImageViewController alloc] init];
//                launchVC.block_activityViewClicked = ^(ActivityViewClickedTag clickedTag){
//                    if (!(clickedTag == kActivityViewClickedView)) {
                        [subscriber sendNext:@YES];
                        [subscriber sendCompleted];
//                    } else {
//
//                    }
//                };
//                self.window.rootViewController = launchVC;
            
            return nil;
        }];
        
    }] flattenMap:^RACStream *(id value) {
     
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            MainTabViewController *mainCtl = [[MainTabViewController alloc] init];
            self.window.rootViewController = mainCtl;
            
            [GDTSDKConfig setHttpsOn];
            //开屏广告初始化并展示代码
            GDTSplashAd *splash = [[GDTSplashAd alloc] initWithAppId:@"1106792551" placementId:@"5030637342814056"];
            splash.delegate = self; //设置代理 //根据iPhone设备不同设置不同背景图
            if ([[UIScreen mainScreen] bounds].size.height >= 568.0f) {
                splash.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LaunchImage-568h"]];
            } else {
                splash.backgroundColor = [UIColor colorWithPatternImage:[UIImage
                                                                         imageNamed:@"LaunchImage"]];
                
            }
            UIImage *splashImage = [UIImage imageNamed:@"SplashNormal"];
            splash.fetchDelay = 3; //开发者可以设置开屏拉取时间，超时则放弃展示 //[可选]拉取并展示全屏开屏广告
            UIImage *backgroundImage = [AppDelegate imageResize:splashImage
                                                    andResizeTo:[UIScreen mainScreen].bounds.size];
            splash.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
            [splash loadAdAndShowInWindow:self.window];
            self.splash = splash;
            
            return nil;
        }];
        
    }] subscribeNext:^(id x) {
        
    }];
    
    [subject_init sendNext:@1];
}

+ (UIImage *)imageResize:(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)splashAdWillPresentFullScreenModal:(GDTSplashAd *)splashAd {
    [ReportStatisticsTool reportStatisticSerialNumber:openapp_splash_ad jsonDataString:@"点击广点通广告"];
}

-(void)splashAdClosed:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
    self.splash = nil;
}

#pragma mark 极光初始化
-(void)initJpushSDKWithOptions:(NSDictionary *)launchOptions{
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    // NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:kJpushAppKey
                          channel:kChannel
                 apsForProduction:kIsProduct
            advertisingIdentifier:nil];
}

#pragma mark - 极光推送
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark- JPUSHRegisterDelegate
// iOS 10 Support   前台得到推送
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    DLOG(@"iOS 10  前台收到推送 willPresentNotification userInfo == %@",userInfo);
    
    [UIUtil alertTitle:@"温馨提示" mesasge:@"你收到一条新的消息，是否打开？" confirmTitle:@"确定" cancelTitle:@"取消" confirmHandler:^(UIAlertAction *confirmAction) {
        //跳转到指定界面
        [self pushToCertainPageWithUserInfo:userInfo];
    } cancelHandler:^(UIAlertAction *cancelAction) {
        
    } viewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    DLOG(@"iOS 10 didReceiveNotificationResponse  userInfo == %@",userInfo);
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
    
    //ios10 收到消息通知
    [self pushToCertainPageWithUserInfo:userInfo];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    DLOG(@"iOS6 didReceiveRemoteNotification  userInfo == %@",userInfo);
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    //iOS6 收到消息通知  跳转指定界面
    [self pushToCertainPageWithUserInfo:userInfo];
}

-(void)pushToCertainPageWithUserInfo:(NSDictionary* )userInfo{
    [ReportStatisticsTool reportStatisticSerialNumber:j_push jsonDataString:@"收到极光推送通知"];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {

    //设置badge值，本地仍须调用UIApplication:setApplicationIconBadgeNumber函数
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];//清空JPush服务器中存储的badge值
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        [JPUSHService setBadge:0];//清空JPush服务器中存储的badge值
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma -mark 支付
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    } else if ([url.host isEqualToString:@"pay"]){

         [WXApi handleOpenURL:url delegate:self];

    }
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    if ([url.host isEqualToString:@"pay"]){//微信支付
        [WXApi handleOpenURL:url delegate:self];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"paySuceessToOrder" object:@"wxPay"];
        
    }
    return [WXApi handleOpenURL:url delegate:self];
}

-(void)onResp:(BaseResp*)resp{
    if ([resp isKindOfClass:[PayResp class]]){
        
        PayResp*response=(PayResp*)resp;
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"paySuceessToOrder" object:response];
        
        switch(response.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                NSLog(@"支付成功");
                break;
            default:
                NSLog(@"支付失败，retcode=%d",resp.errCode);
                break;
        }
    }
}


@end
