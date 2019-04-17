//
//  PresenterSberPong.m
//  SberPong
//
//  Created by Dmitry Shapkin on 17/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "PresenterSberPong.h"


int level = 1;

@implementation PresenterSberPong

- (instancetype)initWithView:(SberPongMainView *)view model:(GameSberPong *)model
{
    self = [super init];
    if (self) {
        _game = model;
        _view = view;
    }
    
    return self;
}

- (void)showUserInterface {
    [self.view createUserInterface];
}

- (void)startTimer
{
    if (!self.view.timer)
    {
        self.view.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(moveBall) userInfo:nil repeats:YES];
    }
    self.view.greenTableView.ball.hidden = NO;
}

- (void)stop
{
    if (self.view.timer)
    {
        [self.view.timer invalidate];
        self.view.timer = nil;
    }
    self.view.greenTableView.ball.hidden = YES;
}

- (void)moveBall
{
    self.view.greenTableView.ball.center = CGPointMake(self.view.greenTableView.ball.center.x + self.game.dx * self.game.speed, self.view.greenTableView.ball.center.y + self.game.dy * self.game.speed);
    
    [self checkCollision:CGRectMake(0, 0, 0, self.view.greenTableView.bounds.size.height) X:fabs(self.game.dx) Y:0];
    
    [self checkCollision:CGRectMake(self.view.greenTableView.bounds.size.width, 0, 20, self.view.greenTableView.bounds.size.height) X:-fabs(self.game.dx) Y:0];
    
    if ([self checkCollision:self.view.greenTableView.paddleTop.frame X:(self.view.greenTableView.ball.center.x - self.view.greenTableView.paddleTop.center.x) / 32.0 Y:1]) {
        [self increaseSpeed];
    }
    if ([self checkCollision:self.view.greenTableView.paddleBottom.frame X:(self.view.greenTableView.ball.center.x - self.view.greenTableView.paddleBottom.center.x) / 32.0 Y:-1]) {
        [self increaseSpeed];
    }
    [self addScore];
    [self computerPlayer];
}

- (void)increaseSpeed
{
    self.game.speed += 0.5;
    if (self.game.speed > 10)
    {
        self.game.speed = 10;
    }
}

- (BOOL)checkCollision:(CGRect)rect X:(float)x Y:(float)y
{
    if (CGRectIntersectsRect(self.view.greenTableView.ball.frame, rect))
    {
        if (x != 0) self.game.dx = x;
        if (y != 0) self.game.dy = y;
        return YES;
    }
    return NO;
}

- (void)computerPlayer
{
    if (self.view.greenTableView.ball.center.y < (CGFloat)(self.view.greenTableView.bounds.size.height / 2))
    {
        if (self.view.greenTableView.ball.center.x > (CGFloat)(self.view.greenTableView.paddleTop.center.x) && self.view.greenTableView.paddleTop.center.x <= self.view.greenTableView.frame.size.width - 45.0)
        {
            self.view.greenTableView.paddleTop.center = CGPointMake(self.view.greenTableView.paddleTop.center.x + (CGFloat)level, self.view.greenTableView.paddleTop.center.y);
        }
        else if (self.view.greenTableView.ball.center.x < (CGFloat)self.view.greenTableView.paddleTop.center.x && self.view.greenTableView.paddleTop.center.x >= 45.0)
        {
            self.view.greenTableView.paddleTop.center = CGPointMake(self.view.greenTableView.paddleTop.center.x - (CGFloat)level, self.view.greenTableView.paddleTop.center.y);
        }
    }
}

- (void)startStopGameProcess
{
    [self stop];
    
    if ([self.game gameOver]) {
        NSLog(@"Игра окончена");
        [self.view flipTable:self.view.greenTableView];
        return;
    }
    [self.game resetDirection];
    [self startTimer];
}

- (BOOL)addScore
{
    // Coming soon - реализую чуть попозже
    if (self.view.greenTableView.ball.center.y < 0 || self.view.greenTableView.ball.center.y >= self.view.view.bounds.size.height)
    {
        int s1 = [self.view.greenTableView.scoreTop.text intValue];
        int s2 = [self.view.greenTableView.scoreBottom.text intValue];
        
        if (self.view.greenTableView.ball.center.y < 0) ++s2; else ++s1;
        self.view.greenTableView.scoreTop.text = [NSString stringWithFormat:@"%u", s1];
        self.view.greenTableView.scoreBottom.text = [NSString stringWithFormat:@"%u", s2];
        
        self.game.scoreTop = s1;
        self.game.scoreBottom = s2;
        
        NSInteger gameOver = [self.game gameOver];
        if (gameOver)
        {
            if (s1 > s2)
            {
                NSLog(@"Компьютер выиграл");
                NSInteger currentComputerScore = [[[NSUserDefaults standardUserDefaults] stringForKey:@"computerScore"] integerValue];
                currentComputerScore++;
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", currentComputerScore] forKey:@"computerScore"];
            }
            else
            {
                NSLog(@"Вы выиграли");
                NSInteger currentUserScore = [[[NSUserDefaults standardUserDefaults] stringForKey:@"userScore"] integerValue];
                currentUserScore++;
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", currentUserScore] forKey:@"userScore"];
            }
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"scoreHasBeenSet"];
            [self startStopGameProcess];
        }
        else
        {
            [self.game resetDirection];
        }
        return YES;
    }
    return NO;
}

@end
