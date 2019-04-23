//
//  Enemy.m
//  Objc-ChainOfResponsibility
//
//  Created by Dmitry Shapkin on 23/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "Enemy.h"


@implementation Enemy

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.strength = 600;
    }
    return self;
}

@end
