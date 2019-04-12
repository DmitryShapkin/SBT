//
//  RulesViewController.m
//  SberPong
//
//  Created by Dmitry Shapkin on 12/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "RulesViewController.h"


@interface RulesViewController ()

@end


@implementation RulesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *lightGraySberColor = [UIColor colorWithRed:240.0/255.0 green:243.0/255.0 blue:252.0/255.0 alpha:1];
    self.view.backgroundColor = lightGraySberColor;
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"Правила игры:\n\nИгра до 5-ти очков";
    titleLabel.textColor = [UIColor colorWithRed:13.0/255.0 green:10.0/255.0 blue:37.0/255.0 alpha:1];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.numberOfLines = 0;
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:22]];
    
    [self.view addSubview:titleLabel];
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
      [titleLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
      [titleLabel.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
      [titleLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20.0],
      [titleLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20.0],
   ]];
}

@end
