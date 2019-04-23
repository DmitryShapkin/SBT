//
//  Soldier.m
//  Objc-ChainOfResponsibility
//
//  Created by Dmitry Shapkin on 23/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "Soldier.h"


@implementation Soldier

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.strength = 100;
    }
    return self;
}

- (void)shouldDefeatWithStrength:(NSInteger)amount
{
    if (amount < self.strength)
    {
        NSLog(@"Солдат победил врага");
    }
    else
    {
        [self.nextRank shouldDefeatWithStrength:amount];
    }
}

@end
