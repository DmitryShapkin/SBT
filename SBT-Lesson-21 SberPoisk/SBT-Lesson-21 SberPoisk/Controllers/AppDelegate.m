//
//  AppDelegate.m
//  SBT-Lesson-21 SberPoisk
//
//  Created by Dmitry Shapkin on 19/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "AppDelegate.h"
#import "DSViewController.h"
#import "SberColor.h"


@import UserNotifications;


@interface AppDelegate ()

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self configureNavigationBar];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    DSViewController *vc = [[DSViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)configureNavigationBar
{
    [[UINavigationBar appearance] setBarTintColor:[SberColor darkGreenSberColor]];
    [UINavigationBar appearance].translucent = NO;
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [UIColor whiteColor]
                                                           }];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}


@end
