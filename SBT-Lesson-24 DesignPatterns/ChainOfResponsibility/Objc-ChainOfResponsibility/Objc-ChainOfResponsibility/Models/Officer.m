//
//  Officer.m
//  Objc-ChainOfResponsibility
//
//  Created by Dmitry Shapkin on 23/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

#import "Officer.h"

@implementation Officer

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.strength = 500;
    }
    return self;
}

- (void)shouldDefeatWithStrength:(NSInteger)amount
{
    if (amount < self.strength)
    {
        NSLog(@"Офицер победил врага");
    }
    else
    {
        [self.nextRank shouldDefeatWithStrength:amount];
    }
}

@end
