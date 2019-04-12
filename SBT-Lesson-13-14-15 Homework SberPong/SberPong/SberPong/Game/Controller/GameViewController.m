//
//  GameViewController.m
//  SberPong
//
//  Created by Dmitry Shapkin on 08/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "GameViewController.h"
#import "SberPongTableView.h"


@interface GameViewController ()

@property (nonatomic, assign) NSInteger maxScore;
@property (nonatomic, strong) SberPongTableView *greenTableView;
@property (nonatomic, strong) UIButton *pauseButton;
@property (nonatomic, assign) BOOL isPauseOn;
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic) float dx;
@property (nonatomic) float dy;
@property (nonatomic) float speed;

@end


@implementation GameViewController

int level = 1;

- (void)dealloc
{
    NSLog(@"dealloc GameViewController");
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"init GameViewController");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createUserInterface];
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"viewWillDisappear");
    
    if (!self.isPauseOn && !self.pauseButton.isHidden)
    {
        NSLog(@"Состояние для игрового процесса с выключенной паузой");
        [self pauseButtonPressed:self.pauseButton];
    }
}

- (void)createUserInterface
{
    UIColor *lightGraySberColor = [UIColor colorWithRed:240.0/255.0 green:243.0/255.0 blue:252.0/255.0 alpha:1];
    self.view.backgroundColor = lightGraySberColor;
    self.maxScore = 5;
    
    [self setupSberPongTable];
    [self setupPauseButton];
}

- (void)setupSberPongTable
{
    UIColor *greenSberColor = [UIColor colorWithRed:20.0/255.0 green:188.0/255.0 blue:77.0/255.0 alpha:1];
    CGFloat tabBarHeight = CGRectGetHeight(self.tabBarController.tabBar.frame);
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    
//    self.greenTableView = [[SberPongTableView alloc] initWithFrame:CGRectZero];
    self.greenTableView = [[SberPongTableView alloc] initWithFrame:CGRectMake(20.0, statusBarHeight + 60.0, CGRectGetWidth(self.view.bounds) - 40, CGRectGetHeight(self.view.bounds) - tabBarHeight - statusBarHeight - 116.0)];
    self.greenTableView.backgroundColor = greenSberColor;
    self.greenTableView.isFlipped = NO;
    self.greenTableView.delegate = self;
//    self.greenTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.greenTableView];
    
//    [NSLayoutConstraint activateConstraints:@[
//          [self.greenTableView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:10 + tabBarHeight + statusBarHeight],
//          [self.greenTableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-20],
//          [self.greenTableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20],
//          [self.greenTableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20],
//    ]];
}

- (void)setupPauseButton
{
    UIColor *blueSberColor = [UIColor colorWithRed:222.0/255.0 green:226.0/255.0 blue:237.0/255.0 alpha:1];
    
    self.pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.pauseButton.enabled = NO;
    [self.pauseButton setHidden:YES];
    self.pauseButton.contentEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 30);
    self.pauseButton.backgroundColor = blueSberColor;
    self.pauseButton.layer.cornerRadius = 20.f;
    [self.pauseButton setTitle:@"Пауза" forState:UIControlStateNormal];
    [self.pauseButton setTitleColor:[UIColor colorWithRed:47.0/255.0 green:51.0/255.0 blue:63.0/255.0 alpha:1] forState:UIControlStateNormal];
    [self.pauseButton addTarget:self action:@selector(pauseButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.pauseButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.pauseButton];
    
    [NSLayoutConstraint activateConstraints:@[
      [self.pauseButton.bottomAnchor constraintEqualToAnchor:self.greenTableView.topAnchor constant: -10],
      [self.pauseButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
      [self.pauseButton.heightAnchor constraintEqualToConstant: 40.f],
    ]];
}


#pragma mark - Actions

- (void)pauseButtonPressed:(UIButton*)button
{
    if (!self.isPauseOn)
    {
        NSLog(@"Поставили на паузу");
        self.isPauseOn = YES;
        [button setTitle:@"Продолжить" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer = nil;
        
        [UIView animateWithDuration:0.3f animations:^{
            self.pauseButton.backgroundColor = [UIColor colorWithRed:20.0/255.0 green:188.0/255.0 blue:77.0/255.0 alpha:1];
            [self.pauseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }];
    }
    else
    {
        NSLog(@"Сняли с паузы");
        self.isPauseOn = NO;
        [button setTitle:@"Пауза" forState:UIControlStateNormal];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(moveBall) userInfo:nil repeats:YES];
        
        [UIView animateWithDuration:0.3f animations:^{
            self.pauseButton.backgroundColor = [UIColor colorWithRed:222.0/255.0 green:226.0/255.0 blue:237.0/255.0 alpha:1];
            [self.pauseButton setTitleColor:[UIColor colorWithRed:47.0/255.0 green:51.0/255.0 blue:63.0/255.0 alpha:1] forState:UIControlStateNormal];
        }];
    }
}

- (void)flipTable:(SberPongTableView*)table
{
    table.isFlipped = !table.isFlipped;
    
    [self setAllItemsInTabBar:self.tabBarController toEnableState:NO];
    
    [UIView transitionWithView:table duration:2.0 options:UIViewAnimationOptionTransitionFlipFromRight |UIViewAnimationOptionCurveEaseInOut animations:^{
        if (!table.isFlipped)
        {
            NSLog(@"messageView NO - далее скрываем кнопку Пауза");
            [self.greenTableView.messageView setHidden:NO];
            [self.pauseButton setHidden:YES];
        }
        else
        {
            NSLog(@"messageView YES - далее показываем кнопку Пауза");
            [self.greenTableView.messageView setHidden:YES];
        }
    } completion:^(BOOL finished){
        [self setAllItemsInTabBar:self.tabBarController toEnableState:YES];
        if (!table.isFlipped)
        {
            self.pauseButton.enabled = NO;
        }
        else
        {
            self.pauseButton.enabled = YES;
        }
    }];
}

- (void)setAllItemsInTabBar:(UITabBarController *)aTabBar toEnableState:(BOOL)enableState
{
    NSArray *tabItems = aTabBar.tabBar.items;
    for (UIBarItem *tabItem in tabItems)
    {
        [tabItem setEnabled:enableState];
    }
}

- (void)startStopGameProcess
{
    NSLog(@"startStopGameProcess");
    [self stop];
    
    if ([self gameOver]) {
        NSLog(@"Игра окончена");
        [self flipTable:self.greenTableView];
        return;
    }
    [self resetDirection];
    [self startTimer];
}


#pragma mark - StartNewGameProtocol

- (void)newGame
{
    NSLog(@"New game");
    [self resetDirection];
    self.greenTableView.scoreTop.text = @"0";
    self.greenTableView.scoreBottom.text = @"0";
    [self.greenTableView.messageView setHidden:YES];
    [self flipTable:self.greenTableView];
    [self.pauseButton setHidden:NO];
    
    [self performSelector:@selector(startStopGameProcess) withObject:nil afterDelay:2.0 ];
}

- (int)gameOver
{
    if ([self.greenTableView.scoreTop.text intValue] >= self.maxScore)
    {
        return 1;
    }
    if ([self.greenTableView.scoreBottom.text intValue] >= self.maxScore)
    {
        return 2;
    }
    return 0;
}

- (void)startTimer
{
    if (!self.timer)
    {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(moveBall) userInfo:nil repeats:YES];
    }
    self.greenTableView.ball.hidden = NO;
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
    
    self.speed = 2;
}

- (void)stop
{
    if (self.timer)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.greenTableView.ball.hidden = YES;
}

- (void)moveBall
{
    self.greenTableView.ball.center = CGPointMake(self.greenTableView.ball.center.x + self.dx * self.speed, self.greenTableView.ball.center.y + self.dy * self.speed);
    
    [self checkCollision:CGRectMake(0, 0, 0, self.greenTableView.bounds.size.height) X:fabs(self.dx) Y:0];
    
    [self checkCollision:CGRectMake(self.greenTableView.bounds.size.width, 0, 20, self.greenTableView.bounds.size.height) X:-fabs(self.dx) Y:0];
    
    if ([self checkCollision:self.greenTableView.paddleTop.frame X:(self.greenTableView.ball.center.x - self.greenTableView.paddleTop.center.x) / 32.0 Y:1]) {
        [self increaseSpeed];
    }
    if ([self checkCollision:self.greenTableView.paddleBottom.frame X:(self.greenTableView.ball.center.x - self.greenTableView.paddleBottom.center.x) / 32.0 Y:-1]) {
        [self increaseSpeed];
    }
    [self addScore];
    [self computerPlayer];
}

- (void)increaseSpeed
{
    self.speed += 0.5;
    if (self.speed > 10)
    {
        self.speed = 10;
    }
}

- (BOOL)checkCollision:(CGRect)rect X:(float)x Y:(float)y
{
    if (CGRectIntersectsRect(self.greenTableView.ball.frame, rect))
    {
        if (x != 0) self.dx = x;
        if (y != 0) self.dy = y;
        return YES;
    }
    return NO;
}

- (void)computerPlayer
{
        if (self.greenTableView.ball.center.y < (CGFloat)(self.greenTableView.bounds.size.height / 2))
        {
            if (self.greenTableView.ball.center.x > (CGFloat)(self.greenTableView.paddleTop.center.x))
            {
                self.greenTableView.paddleTop.center = CGPointMake(self.greenTableView.paddleTop.center.x + (CGFloat)level, self.greenTableView.paddleTop.center.y);
            }
            else if (self.greenTableView.ball.center.x < (CGFloat)self.greenTableView.paddleTop.center.x)
            {
                self.greenTableView.paddleTop.center = CGPointMake(self.greenTableView.paddleTop.center.x - (CGFloat)level, self.greenTableView.paddleTop.center.y);
            }
        }
}

- (BOOL)addScore
{
    // Coming soon - реализую чуть попозже
    if (self.greenTableView.ball.center.y < 0 || self.greenTableView.ball.center.y >= self.view.bounds.size.height)
    {
        int s1 = [self.greenTableView.scoreTop.text intValue];
        int s2 = [self.greenTableView.scoreBottom.text intValue];
        
        if (self.greenTableView.ball.center.y < 0) ++s2; else ++s1;
        self.greenTableView.scoreTop.text = [NSString stringWithFormat:@"%u", s1];
        self.greenTableView.scoreBottom.text = [NSString stringWithFormat:@"%u", s2];
        
        int gameOver = [self gameOver];
        if (gameOver)
        {
            if (s1 > s2)
            {
                NSInteger currentComputerScore = [[[NSUserDefaults standardUserDefaults] stringForKey:@"computerScore"] integerValue];
                currentComputerScore++;
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", currentComputerScore] forKey:@"computerScore"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            else
            {
                NSInteger currentUserScore = [[[NSUserDefaults standardUserDefaults] stringForKey:@"userScore"] integerValue];
                currentUserScore++;
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", currentUserScore] forKey:@"userScore"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            [self startStopGameProcess];
        }
        else
        {
            [self resetDirection];
        }
        return YES;
    }
    return NO;
}


#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint currentPoint = [touch locationInView:self.greenTableView];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.greenTableView.paddleBottom.center = CGPointMake(currentPoint.x, self.greenTableView.paddleBottom.center.y);
    }];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint currentPoint = [touch locationInView:self.greenTableView];
    
    if (currentPoint.x >= self.greenTableView.frame.size.width - 45.0)
    {
        self.greenTableView.paddleBottom.center = CGPointMake(self.greenTableView.frame.size.width - 45.0, self.greenTableView.frame.size.height - 26);
    }
    else if (currentPoint.x <= 45.0)
    {
        self.greenTableView.paddleBottom.center = CGPointMake(45.0, self.greenTableView.frame.size.height - 26);
    }
    else
    {
        self.greenTableView.paddleBottom.center = CGPointMake(currentPoint.x, self.greenTableView.frame.size.height - 26);
    }
}

- (void)changeSpeed:(NSInteger)speedLevel
{
    NSLog(@"speedLevel change");
}


@end
