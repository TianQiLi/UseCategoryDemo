//
//  AppDelegate.m
//  UseCategoryDemo
//
//  Created by litianqi on 2018/5/14.
//  Copyright © 2018年 tqUDown. All rights reserved.
//

#import "AppDelegate.h"
#import "SubViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    UIViewController * nav = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    
    SubViewController * vc = [[SubViewController alloc] initWithTableStyle:UITableViewStyleGrouped autoAdjustScrollViewInsets:YES];
    vc.type = 5;
    
    UINavigationController * nav2 = [[UINavigationController alloc] initWithRootViewController:vc];
    
    UITabBarController * tabBarContr = [[UITabBarController alloc] init];
    tabBarContr.viewControllers = @[nav,nav2];
    
    self.window.rootViewController = tabBarContr;
    [self configTabItems:tabBarContr.tabBar.items];
    tabBarContr.tabBar.translucent = YES;
    
//    [[UITabBar appearance] setBackgroundColor:[UIColor redColor]];
        [self.window makeKeyAndVisible];
    return YES;
}

- (void)configTabItems:(NSArray *)array{
    NSArray * titleArray = @[@"首页",@"second"];
    NSInteger i =0;
    for (UITabBarItem * item in array) {
        [item setTitle:titleArray[i++]];
        [item setTitlePositionAdjustment:UIOffsetMake(0, -20)];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
