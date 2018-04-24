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


// 引入JPush功能所需头文件
#import <JPUSHService.h>
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
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
            return nil;
        }];
        
    }] subscribeNext:^(id x) {
        
    }];
    
    [subject_init sendNext:@1];
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


@end
