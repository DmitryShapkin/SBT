//
//  ViewController.m
//  ObjC-AbstractFactory
//
//  Created by Dmitry Shapkin on 21/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "ViewController.h"
#import "RussianFactory.h"
#import "AmericanFactory.h"
#import "EuropeanFactory.h"


@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /** Собираем фабрики */
    
    RussianFactory *russianFactory = [RussianFactory new];
    [russianFactory produceBankCard];
    [russianFactory producePhone];
    
    AmericanFactory *americanFactory = [AmericanFactory new];
    [americanFactory produceBankCard];
    [americanFactory producePhone];
    
    EuropeanFactory *europeanFactory = [EuropeanFactory new];
    [europeanFactory produceBankCard];
    [europeanFactory producePhone];
}

@end
