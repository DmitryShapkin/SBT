//
//  ViewController.m
//  SBT-Lesson-3-Homework
//
//  Created by Dmitry Shapkin on 01/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

#import "ViewController.h"
#import "Granny.h"
#import "Grandson.h"
#import "BorschDelegate.h"


@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Granny *granny = [Granny new];
    id<BorshDelegate> grandson = [Grandson new];
    granny.borshDelegate = grandson;
    
    [granny serveLunch];
    
    // Задание:
    // необходимо дописать классы Granny и Grandson таким образом, чтобы
    // при вызове метода serveLunch были выведены в консоль
    // последовательно все события взаимодействия объекта и его делегата
}

@end
