//
//  GameViewController.m
//  SberPong
//
//  Created by Dmitry Shapkin on 08/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "SberPongMainView.h"
#import "SberPongTableView.h"
#import "SberPongColor.h"


@interface SberPongMainView ()

@property (nonatomic, strong) UIButton *pauseButton;
@property (nonatomic, assign) BOOL isPauseOn;

@end


@implementation SberPongMainView

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.presenter showUserInterface];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (!self.isPauseOn && !self.pauseButton.isHidden)
    {
        /**
         Состояние для игрового процесса с выключенной паузой
         */
        [self pauseButtonPressed:self.pauseButton];
    }
}

- (void)createUserInterface
{
    self.view.backgroundColor = [SberPongColor lightGraySberColor];
    [self setupSberPongTable];
    [self setupPauseButton];
}

- (void)setupSberPongTable
{
    CGFloat tabBarHeight = CGRectGetHeight(self.tabBarController.tabBar.frame);
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    
    self.greenTableView = [[SberPongTableView alloc] initWithFrame:CGRectMake(20.0, statusBarHeight + 60.0, CGRectGetWidth(self.view.bounds) - 40, CGRectGetHeight(self.view.bounds) - tabBarHeight - statusBarHeight - 116.0)];
    self.greenTableView.backgroundColor = [SberPongColor greenSberColor];
    self.greenTableView.isFlipped = NO;
    self.greenTableView.delegate = self;
    [self.view addSubview:self.greenTableView];
}

- (void)setupPauseButton
{
    self.pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.pauseButton.enabled = NO;
    [self.pauseButton setHidden:YES];
    self.pauseButton.contentEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 30);
    self.pauseButton.backgroundColor = [SberPongColor graySberColor];
    self.pauseButton.layer.cornerRadius = 20.f;
    [self.pauseButton setTitle:@"Пауза" forState:UIControlStateNormal];
    [self.pauseButton setTitleColor:[SberPongColor blackFontSberColor] forState:UIControlStateNormal];
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
            self.pauseButton.backgroundColor = [SberPongColor greenSberColor];
            [self.pauseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }];
    }
    else
    {
        NSLog(@"Сняли с паузы");
        self.isPauseOn = NO;
        [button setTitle:@"Пауза" forState:UIControlStateNormal];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self.presenter selector:@selector(moveBall) userInfo:nil repeats:YES];
        
        [UIView animateWithDuration:0.3f animations:^{
            self.pauseButton.backgroundColor = [SberPongColor graySberColor];
            [self.pauseButton setTitleColor:[SberPongColor blackFontSberColor] forState:UIControlStateNormal];
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
            [self.greenTableView.messageView setHidden:NO];
            [self.pauseButton setHidden:YES];
        }
        else
        {
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


#pragma mark - StartNewGameProtocol

- (void)newGame
{
    self.greenTableView.scoreTop.text = @"0";
    self.greenTableView.scoreBottom.text = @"0";
    [self.greenTableView.messageView setHidden:YES];
    [self flipTable:self.greenTableView];
    [self.pauseButton setHidden:NO];
    
    [self performSelector:@selector(startNewGame) withObject:nil afterDelay:2.0 ];
}

- (void)startNewGame
{
    [self.presenter startStopGameProcess];
}


#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint currentPoint = [touch locationInView:self.greenTableView];
    
    
    if (currentPoint.x >= self.greenTableView.frame.size.width - 45.0)
    {
        [UIView animateWithDuration:0.3f animations:^{
            self.greenTableView.paddleBottom.center = CGPointMake(self.greenTableView.frame.size.width - 45.0, self.greenTableView.paddleBottom.center.y);
        }];
    }
    else if (currentPoint.x <= 45.0)
    {
        [UIView animateWithDuration:0.3f animations:^{
            self.greenTableView.paddleBottom.center = CGPointMake(45.0, self.greenTableView.paddleBottom.center.y);
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3f animations:^{
            self.greenTableView.paddleBottom.center = CGPointMake(currentPoint.x, self.greenTableView.paddleBottom.center.y);
        }];
    }
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

@end
