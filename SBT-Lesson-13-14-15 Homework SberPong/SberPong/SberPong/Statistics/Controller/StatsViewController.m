//
//  StatsViewController.m
//  SberPong
//
//  Created by Dmitry Shapkin on 08/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "StatsViewController.h"


@interface StatsViewController ()

@end


@implementation StatsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"init StatsViewController");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
}

@end
