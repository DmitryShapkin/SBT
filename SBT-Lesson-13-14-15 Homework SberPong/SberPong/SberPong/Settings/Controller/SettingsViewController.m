//
//  SettingsViewController.m
//  SberPong
//
//  Created by Dmitry Shapkin on 08/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "SettingsViewController.h"


@interface SettingsViewController ()

@end


@implementation SettingsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"init SettingsViewController");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
}


@end
