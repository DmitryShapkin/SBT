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
@property (strong, nonatomic) NSTimer * timer;
@property (nonatomic) float dx;
@property (nonatomic) float dy;
@property (nonatomic) float speed;

@end

@implementation GameViewController

int level = 1;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createUserInterface];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self newGame];
}


- (void)createUserInterface
{
    self.maxScore = 5;
    
    [self setupSberPongTable];
    [self setupPauseButton];
}

- (void)setupSberPongTable
{
    UIColor *greenSberColor = [UIColor colorWithRed:20.0/255.0 green:188.0/255.0 blue:77.0/255.0 alpha:1];
    UIColor *lightGraySberColor = [UIColor colorWithRed:240.0/255.0 green:243.0/255.0 blue:252.0/255.0 alpha:1];
    
    CGFloat tabBarHeight = CGRectGetHeight(self.tabBarController.tabBar.frame);
    
    self.greenTableView = [[SberPongTableView alloc] init];
    self.greenTableView.backgroundColor = greenSberColor;

    self.greenTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.greenTableView];

    [NSLayoutConstraint activateConstraints:@[
      [self.greenTableView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:20 + tabBarHeight],
      [self.greenTableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-20],
      [self.greenTableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20],
      [self.greenTableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20],
    ]];

    self.view.backgroundColor = lightGraySberColor;
}

- (void)setupPauseButton
{
    UIColor *blueSberColor = [UIColor colorWithRed:222.0/255.0 green:226.0/255.0 blue:237.0/255.0 alpha:1];
    
    self.pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.pauseButton.contentEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 30);
    self.pauseButton.backgroundColor = blueSberColor;
    self.pauseButton.layer.cornerRadius = 20.f;
    [self.pauseButton setTitle:@"Пауза" forState:UIControlStateNormal];
    [self.pauseButton setTitleColor:[UIColor colorWithRed:47.0/255.0 green:51.0/255.0 blue:63.0/255.0 alpha:1] forState:UIControlStateNormal];
    [self.pauseButton addTarget:self action:@selector(pauseButtonPressed:event:) forControlEvents:UIControlEventTouchUpInside];
    
    self.pauseButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.pauseButton];
    
    [NSLayoutConstraint activateConstraints:@[
      [self.pauseButton.bottomAnchor constraintEqualToAnchor:self.greenTableView.topAnchor constant: -10],
      [self.pauseButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
      [self.pauseButton.heightAnchor constraintEqualToConstant: 40.f],
    ]];
}


#pragma mark - Actions

- (void)pauseButtonPressed:(UIButton*)button event:(UIEvent*) event
{
    if (!self.isPauseOn)
    {
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
        self.isPauseOn = NO;
        [button setTitle:@"Пауза" forState:UIControlStateNormal];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(moveBall) userInfo:nil repeats:YES];
        
        [UIView animateWithDuration:0.3f animations:^{
            self.pauseButton.backgroundColor = [UIColor colorWithRed:222.0/255.0 green:226.0/255.0 blue:237.0/255.0 alpha:1];
            [self.pauseButton setTitleColor:[UIColor colorWithRed:47.0/255.0 green:51.0/255.0 blue:63.0/255.0 alpha:1] forState:UIControlStateNormal];
        }];
    }
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

    //self.paddleBottom.center = correction;

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

- (void)displayMessage:(NSString *)message
{
    [self stop];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"СберПонг" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Принято" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if ([self gameOver]) {
            [self newGame];
            return;
        }
        [self reset];
        [self start];
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)newGame
{
    [self reset];
    self.greenTableView.scoreTop.text = @"0";
    self.greenTableView.scoreBottom.text = @"0";
    NSString *nextLevel =  [@"Уровень " stringByAppendingString: [NSString stringWithFormat: @"%d", level]] ;
    [self displayMessage: [nextLevel stringByAppendingString: @"\n\nВы готовы?"]];
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

- (void)start
{
    //self.greenTableView.ball.center = CGPointMake(CGRectGetMidX(self.greenTableView.bounds), CGRectGetMidY(self.greenTableView.bounds));
    if (!_timer)
    {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(moveBall) userInfo:nil repeats:YES];
    }
    self.greenTableView.ball.hidden = NO;
}

- (void)reset
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
    
    [self checkCollision:CGRectMake(0, 0, 0, self.greenTableView.bounds.size.height) X:fabs(_dx) Y:0];
    
    [self checkCollision:CGRectMake(self.greenTableView.bounds.size.width, 0, 20, self.greenTableView.bounds.size.height) X:-fabs(_dx) Y:0];
    
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
    
    // super player
    //_paddleTop.center = CGPointMake(self.ball.center.x, self.paddleTop.center.y);
    
    // ordinary player
    /*
     if (self.ball.center.y < self.view.bounds.size.height/2) {
     if (self.ball.center.x > self.paddleTop.center.x){
     self.paddleTop.center = CGPointMake(self.paddleTop.center.x + arc4random_uniform(self.speed), self.paddleTop.center.y);
     } else {
     self.paddleTop.center = CGPointMake(self.paddleTop.center.x - arc4random_uniform(self.speed), self.paddleTop.center.y);
     }
     }
     */
    
    // level player
    if (self.greenTableView.ball.center.y < self.view.bounds.size.height / 2) {
        if (self.greenTableView.ball.center.x > self.greenTableView.paddleTop.center.x){
            self.greenTableView.paddleTop.center = CGPointMake(self.greenTableView.paddleTop.center.x + level, self.greenTableView.paddleTop.center.y);
        } else {
            self.greenTableView.paddleTop.center = CGPointMake(self.greenTableView.paddleTop.center.x - level, self.greenTableView.paddleTop.center.y);
        }
    }
    
}

- (BOOL)addScore
{
    if (self.greenTableView.ball.center.y < 0 || self.greenTableView.ball.center.y >= self.view.bounds.size.height) {
        int s1 = [self.greenTableView.scoreTop.text intValue];
        int s2 = [self.greenTableView.scoreBottom.text intValue];
        
        if (self.greenTableView.ball.center.y < 0) ++s2; else ++s1;
        self.greenTableView.scoreTop.text = [NSString stringWithFormat:@"%u", s1];
        self.greenTableView.scoreBottom.text = [NSString stringWithFormat:@"%u", s2];
        
        int gameOver = [self gameOver];
        if (gameOver)
        {
            [self upgradeLevelForResult: gameOver];
            [self displayMessage:[NSString stringWithFormat:@"Игрок %i выиграл!", gameOver]];
        }
        else
        {
            [self reset];
        }
        
        return YES;
    }
    return NO;
}

-(void)upgradeLevelForResult:(int)winner
{
    if (winner == 1 && level > 1)
    {
        level--;
    }
    if (winner == 2)
    {
        level++;
    }
}

@end
