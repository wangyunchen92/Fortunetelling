//
//  MainViewController.m
//  ZrtTool
//
//  Created by BillyWang on 15/10/14.
//  Copyright © 2015年 zrt. All rights reserved.
//

#import "MainTabViewController.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "DSNavViewController.h"
#import "MineCalculateListViewController.h"
#import "FortuneDetailViewController.h"
#import "EveryDayViewController.h"

#import "ProductListViewController.h"


@interface MainTabViewController()<UITabBarControllerDelegate>

@end

@implementation MainTabViewController

#pragma mark -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    [self constructNotLoginViewControllers];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.selectedViewController beginAppearanceTransition: NO animated: animated];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.selectedViewController endAppearanceTransition];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    UINavigationController *nav = (UINavigationController *)viewController;
    
    if ([tabBarController.viewControllers containsObject:nav]) {
//        UIViewController *vc = [nav.viewControllers objectAtIndex:0];
//        
//        if ([vc respondsToSelector:@selector(refreshDefaultData)]) {
//            [vc performSelector:@selector(refreshDefaultData)];
//        }
    }
    
    return YES;
}

#pragma mark - 手势密码验证

- (void)createViewControllers
{
//    FamilyViewController *hvc    = [[FamilyViewController alloc] init];
    
    MainViewController *hvc      = [[MainViewController alloc] init];
    FortuneDetailViewController *fvc = [[FortuneDetailViewController alloc] init];
    fvc.isshowNavback = NO;
    ProductListViewController *evc = [[ProductListViewController alloc] init];
    MineCalculateListViewController *mvc = [[MineCalculateListViewController alloc] init];

    DSNavViewController *hNav    = [[DSNavViewController alloc] initWithRootViewController:hvc];
    DSNavViewController *mNav    = [[DSNavViewController alloc] initWithRootViewController:mvc];
    DSNavViewController *eNav    = [[DSNavViewController alloc] initWithRootViewController:evc];
    DSNavViewController *fNav    = [[DSNavViewController alloc] initWithRootViewController:fvc];
    
    [self setTabBarItem:hNav
                  title:@"测算大全"
            selectImage:@"测算大全选中"
          unselectImage:@"测算大全未选中"
                    tag:1];
    
    [self setTabBarItem:fNav
                  title:@"八字测算"
            selectImage:@"八字测算选中"
          unselectImage:@"八字测算未选中"
                    tag:2];
    
    [self setTabBarItem:eNav
                  title:@"商品"
            selectImage:@"每日宜忌选中"
          unselectImage:@"每日宜忌未选中"
                    tag:3];
    
    [self setTabBarItem:mNav
                  title:@"我的测算"
            selectImage:@"我的测算选中"
          unselectImage:@"我的测算未选中"
                    tag:4];
    
    self.viewControllers = @[hNav,fNav,eNav,mNav];
}

- (void)constructNotLoginViewControllers
{
    [self createViewControllers];
    
    self.selectedIndex = 0;
//    self.tabBar.backgroundImage = [UIImage imageWithColor:RGB(237, 217, 219)];
    self.tabBar.backgroundImage = [UIImage imageWithColor:[UIColor whiteColor]];
}

- (void)setTabBarItem:(UINavigationController *) navController
                title:(NSString *)title
          selectImage:(NSString *)selectImage
        unselectImage:(NSString *)unselectImage
                  tag:(NSUInteger)tag
{
    UIImage * normalSelectImage = [IMAGE_NAME(selectImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * normalImage = [IMAGE_NAME(unselectImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navController.tabBarItem.title = title;
    
    NSDictionary *normalDic = [NSDictionary dictionaryWithObjectsAndKeys:
                               UIColorFromRGB(0x333333),
                               NSForegroundColorAttributeName, nil];
    [navController.tabBarItem setTitleTextAttributes:normalDic forState:UIControlStateSelected];
    
    navController.tabBarItem.image = normalImage;
    navController.tabBarItem.selectedImage = normalSelectImage;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    switch (tabBarController.selectedIndex) {
        case 0:
            [ReportStatisticsTool reportStatisticSerialNumber:main_home_module jsonDataString:@"首页"];
            break;
        case 1:
            [ReportStatisticsTool reportStatisticSerialNumber:main_home_module jsonDataString:@"八字测算"];
            break;
        case 2:
            [ReportStatisticsTool reportStatisticSerialNumber:main_home_module jsonDataString:@"每日宜忌"];
            break;
        case 3:
            [ReportStatisticsTool reportStatisticSerialNumber:main_home_module jsonDataString:@"我的测算"];
            break;
        default:
            break;
    }
}
@end
