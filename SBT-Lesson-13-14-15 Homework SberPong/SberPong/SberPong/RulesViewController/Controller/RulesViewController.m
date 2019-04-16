//
//  RulesViewController.m
//  SberPong
//
//  Created by Dmitry Shapkin on 12/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "RulesViewController.h"
#import "SberPongColor.h"


@interface RulesViewController ()

@end


@implementation RulesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [SberPongColor lightGraySberColor];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"Правила игры:\n\nИгра до 5-ти очков";
    titleLabel.textColor = [SberPongColor blackFontSberColor];
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
