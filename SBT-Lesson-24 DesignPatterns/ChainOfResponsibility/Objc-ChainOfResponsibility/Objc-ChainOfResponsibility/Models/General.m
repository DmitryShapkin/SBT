//
//  General.m
//  Objc-ChainOfResponsibility
//
//  Created by Dmitry Shapkin on 23/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "General.h"


@implementation General

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.strength = 1000;
    }
    return self;
}

- (void)shouldDefeatWithStrength:(NSInteger)amount
{
    if (amount < self.strength)
    {
        NSLog(@"Генерал победил врага");
    }
    else
    {
        NSLog(@"Мы не можем победить врага");
    }
}

@end
