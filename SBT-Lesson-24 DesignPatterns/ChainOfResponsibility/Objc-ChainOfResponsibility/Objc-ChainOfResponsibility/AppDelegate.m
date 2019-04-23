//
//  AppDelegate.m
//  Objc-ChainOfResponsibility
//
//  Created by Dmitry Shapkin on 23/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "AppDelegate.h"
#import "ViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    ViewController *vc = [ViewController new];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    return YES;
}
@end
