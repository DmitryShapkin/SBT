//
//  GameSberPong.m
//  SberPong
//
//  Created by Dmitry Shapkin on 17/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "GameSberPong.h"


@implementation GameSberPong

- (void)dealloc
{
    [[NSUserDefaults standardUserDefaults] removeObserver:self forKeyPath:@"ballSpeed"];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _maxScore = 5;
        
        [[NSUserDefaults standardUserDefaults] addObserver:self forKeyPath:@"ballSpeed" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (NSInteger)gameOver
{
    if (self.scoreTop >= self.maxScore)
    {
        return 1;
    }
    if (self.scoreBottom >= self.maxScore)
    {
        return 2;
    }
    return 0;
}

- (void)resetDirection
{
    if (arc4random() % 2) {
        self.dx = -1;
    } else {
        self.dx = 1;
    }
    
    if (self.dy != 0) {
        self.dy = -self.dy;
    } else if (arc4random() % 2) {
        self.dy = -1;
    } else  {
        self.dy = 1;
    }
    
    if ([[NSUserDefaults standardUserDefaults] floatForKey:@"ballSpeed"] == 0)
    {
        self.speed = 2;
    }
    else
    {
        self.speed = [[NSUserDefaults standardUserDefaults] floatForKey:@"ballSpeed"];
    }
}


#pragma mark - Notifications

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    self.speed = [[change objectForKey:@"new"] floatValue];
}

@end
