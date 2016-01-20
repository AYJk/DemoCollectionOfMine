//
//  AppDelegate.m
//  DemoCollectionOfMine
//
//  Created by Andy on 15/12/28.
//  Copyright © 2015年 Andy. All rights reserved.
//

#import "AppDelegate.h"
#import "SWRevealViewController.h"
#import "CenterViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    LeftViewController *leftVC = [[LeftViewController alloc] initWithNibName:@"LeftViewController" bundle:nil];
    CenterViewController *centerVC = [[CenterViewController alloc] initWithNibName:@"CenterViewController" bundle:nil];
    RightViewController *rightVC = [[RightViewController alloc] initWithNibName:@"RightViewController" bundle:nil];
    
    UINavigationController *centerNC = [[UINavigationController alloc] initWithRootViewController:centerVC];
    centerVC.viewControllerTitle =  @"Home";
    SWRevealViewController *revealViewController = [[SWRevealViewController alloc] initWithRearViewController:leftVC frontViewController:centerNC];
    
    revealViewController.rightViewController = rightVC;
    revealViewController.rearViewRevealWidth = 230;
    [revealViewController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    
    self.window.rootViewController = revealViewController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //初始化MagicalRecord
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"MyDataBase.sqlite"];
    
    NSLog(@"%@",NSHomeDirectory());
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [MagicalRecord cleanUp];
}

@end
