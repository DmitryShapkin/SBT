//
//  StatsViewController.m
//  SberPong
//
//  Created by Dmitry Shapkin on 08/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "StatsViewController.h"


@interface StatsViewController ()

@property (nonatomic, strong) UILabel *computerWinLabel;
@property (nonatomic, strong) UILabel *userWinLabel;

@end


@implementation StatsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSLog(@"dispatch_once dispatch_once dispatch_once");
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"userScore"];
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"computerScore"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
        });
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIColor *lightGraySberColor = [UIColor colorWithRed:240.0/255.0 green:243.0/255.0 blue:252.0/255.0 alpha:1];
    self.view.backgroundColor = lightGraySberColor;
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"Рейтинг";
    titleLabel.textColor = [UIColor colorWithRed:13.0/255.0 green:10.0/255.0 blue:37.0/255.0 alpha:1];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:22]];
    [self.view addSubview:titleLabel];
    
    UILabel *userTitleLabel = [UILabel new];
    userTitleLabel.text = @"Ваших побед:";
    userTitleLabel.textColor = [UIColor colorWithRed:125.0/255.0 green:129.0/255.0 blue:140.0/255.0 alpha:1];
    userTitleLabel.textAlignment = NSTextAlignmentCenter;
    [userTitleLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
    [self.view addSubview:userTitleLabel];
    
    self.userWinLabel = [UILabel new];
    self.userWinLabel.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"userScore"];
    self.userWinLabel.textColor = [UIColor colorWithRed:13.0/255.0 green:10.0/255.0 blue:37.0/255.0 alpha:1];
    self.userWinLabel.textAlignment = NSTextAlignmentCenter;
    [self.userWinLabel setFont:[UIFont fontWithName:@"Helvetica" size:80]];
    [self.view addSubview:self.userWinLabel];
    
    UILabel *computerTitleLabel = [UILabel new];
    computerTitleLabel.text = @"Побед компьютера:";
    computerTitleLabel.textColor = [UIColor colorWithRed:125.0/255.0 green:129.0/255.0 blue:140.0/255.0 alpha:1];
    computerTitleLabel.textAlignment = NSTextAlignmentCenter;
    [computerTitleLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
    [self.view addSubview:computerTitleLabel];
    
    self.computerWinLabel = [UILabel new];
    self.computerWinLabel.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"computerScore"];
    self.computerWinLabel.textColor = [UIColor colorWithRed:13.0/255.0 green:10.0/255.0 blue:37.0/255.0 alpha:1];
    self.computerWinLabel.textAlignment = NSTextAlignmentCenter;
    [self.computerWinLabel setFont:[UIFont fontWithName:@"Helvetica" size:80]];
    [self.view addSubview:self.computerWinLabel];

    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    userTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.userWinLabel.translatesAutoresizingMaskIntoConstraints = NO;
    computerTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.computerWinLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
      [titleLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:60.0],
      [titleLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
      [titleLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
      [titleLabel.heightAnchor constraintEqualToConstant:50.0],
      
      [userTitleLabel.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant: 20.0],
      [userTitleLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20.0],
      [userTitleLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20.0],
      
      [self.userWinLabel.topAnchor constraintEqualToAnchor:userTitleLabel.bottomAnchor constant: 20.0],
      [self.userWinLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20.0],
      [self.userWinLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20.0],
      
      [computerTitleLabel.topAnchor constraintEqualToAnchor:self.userWinLabel.bottomAnchor constant: 20.0],
      [computerTitleLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20.0],
      [computerTitleLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20.0],
      
      [self.computerWinLabel.topAnchor constraintEqualToAnchor:computerTitleLabel.bottomAnchor constant: 20.0],
      [self.computerWinLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20.0],
      [self.computerWinLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20.0],
    ]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    self.computerWinLabel.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"computerScore"];
    self.userWinLabel.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"userScore"];
}

@end
