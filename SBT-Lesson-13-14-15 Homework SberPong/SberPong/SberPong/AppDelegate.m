//
//  AppDelegate.m
//  SberPong
//
//  Created by Dmitry Shapkin on 08/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "AppDelegate.h"
#import "SettingsViewController.h"
#import "GameViewController.h"
#import "StatsViewController.h"


@interface AppDelegate ()

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.layer.cornerRadius = 3.f;
    self.window.layer.masksToBounds = YES;
    
    [self setupTabBar];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)setupTabBar
{
    UIColor *graySberColor = [UIColor colorWithRed:53.0/255.0 green:56.0/255.0 blue:65.0/255.0 alpha:1];
    UIColor *greenSberColor = [UIColor colorWithRed:20.0/255.0 green:188.0/255.0 blue:77.0/255.0 alpha:1];
    
    SettingsViewController *settingsViewController = [[SettingsViewController alloc] init];
    settingsViewController.tabBarItem.title = @"Настройки";
    settingsViewController.tabBarItem.image = [UIImage imageNamed:@"settings"];
    
    StatsViewController *statsViewController = [[StatsViewController alloc] init];
    statsViewController.tabBarItem.title = @"Рейтинг";
    statsViewController.tabBarItem.image = [UIImage imageNamed:@"stats"];
    
    GameViewController *gameViewController = [[GameViewController alloc] init];
    gameViewController.tabBarItem.title = @"Играть";
    gameViewController.tabBarItem.image = [UIImage imageNamed:@"paddle"];
    
    SettingsViewController *rulesViewController = [[SettingsViewController alloc] init];
    rulesViewController.tabBarItem.title = @"Правила";
    rulesViewController.tabBarItem.image = [UIImage imageNamed:@"rules"];

    SettingsViewController *adViewController = [[SettingsViewController alloc] init];
    adViewController.tabBarItem.title = @"Реклама";
    adViewController.tabBarItem.image = [UIImage imageNamed:@"advertisement"];
    
    NSArray *viewControllerArray = @[settingsViewController, statsViewController, gameViewController, rulesViewController, adViewController];
    
    for (UIViewController *viewController in viewControllerArray)
    {
        viewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0.0, -4.0);
        [viewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    }
    
    UITabBarController *tabBarViewController = [[UITabBarController alloc] init];
    tabBarViewController.tabBar.translucent = NO;
    tabBarViewController.tabBar.tintColor = greenSberColor;
    tabBarViewController.tabBar.barTintColor = graySberColor;
    tabBarViewController.viewControllers = viewControllerArray;
    tabBarViewController.selectedIndex = 2;

    self.window.rootViewController = tabBarViewController;
}

@end
