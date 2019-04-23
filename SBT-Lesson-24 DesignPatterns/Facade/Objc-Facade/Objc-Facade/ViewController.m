//
//  ViewController.m
//  Objc-Facade
//
//  Created by Dmitry Shapkin on 23/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "ViewController.h"
#import "Supermarket.h"


@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /** Facade */
    Supermarket *supermarket = [Supermarket new];
    NSLog(@"%@", [supermarket buyProducts]);
}

@end
