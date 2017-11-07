//
//  AppDelegate.m
//  Moment
//
//  Created by Andy on 2017/10/26.
//  Copyright © 2017年 Andy. All rights reserved.
//

#import "AppDelegate.h"
#import "NewDynamicsViewController.h"
#import <IQKeyboardManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    self.window =[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NewDynamicsViewController * vc = [NewDynamicsViewController new];
    UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:vc];
    _window.rootViewController = NC;
    [_window makeKeyAndVisible];
    
    //设置SVProgressHUD样式
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    
    [[IQKeyboardManager sharedManager].disabledDistanceHandlingClasses addObjectsFromArray:[NSArray arrayWithObjects:[NewDynamicsViewController class],nil]];
    [[IQKeyboardManager sharedManager].disabledToolbarClasses addObjectsFromArray:[NSArray arrayWithObjects:[NewDynamicsViewController class],nil]];
    
    return YES;
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
