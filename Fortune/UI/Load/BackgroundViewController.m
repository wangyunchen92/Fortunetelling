//
//  BackgroundViewController.m
//  ColorfulFund
//
//  Created by Madis on 16/9/30.
//  Copyright © 2016年 zritc. All rights reserved.
//

#import "BackgroundViewController.h"
#import "LoginViewController.h"

@interface BackgroundViewController ()
@property (nonatomic, copy) void(^autoLoginCallback)(void);
@end

@implementation BackgroundViewController
static BackgroundViewController *_instance = nil;
+ (instancetype)share
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[BackgroundViewController alloc]init];
        _instance.messageUnReadCount = @"";
      });
    return _instance;
}

// 调出登录界面,统一从rootController跳转
- (void)showLoginViewController:(LoginViewController *)loginVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootViewController presentViewController:[[UINavigationController alloc] initWithRootViewController:loginVC] animated:YES completion:nil];
}

// 调出登录界面
- (void)showLoginViewController:(LoginViewController *)loginVC animated:(BOOL)animated completion:(void (^ __nullable)(void))completion
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (rootViewController.presentedViewController) {
        rootViewController = rootViewController.presentedViewController;
    }
    [rootViewController presentViewController:[[UINavigationController alloc] initWithRootViewController:loginVC] animated:animated completion:^{
        if (completion) {
            completion();
        }
    }];
}
@end
