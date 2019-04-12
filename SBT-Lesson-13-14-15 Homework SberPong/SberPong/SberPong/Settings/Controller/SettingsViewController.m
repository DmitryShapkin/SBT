//
//  SettingsViewController.m
//  SberPong
//
//  Created by Dmitry Shapkin on 08/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "SettingsViewController.h"


@interface SettingsViewController ()

@end


@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *lightGraySberColor = [UIColor colorWithRed:240.0/255.0 green:243.0/255.0 blue:252.0/255.0 alpha:1];
    self.view.backgroundColor = lightGraySberColor;
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"Настройки";
    titleLabel.textColor = [UIColor colorWithRed:13.0/255.0 green:10.0/255.0 blue:37.0/255.0 alpha:1];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:22]];
    [self.view addSubview:titleLabel];
    
    UILabel *subTitleLabel = [UILabel new];
    subTitleLabel.text = @"Поменять скорость игры";
    subTitleLabel.textColor = [UIColor colorWithRed:125.0/255.0 green:129.0/255.0 blue:140.0/255.0 alpha:1];
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    subTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    subTitleLabel.numberOfLines = 0;
    [subTitleLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
    [self.view addSubview:subTitleLabel];
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"Медленно", @"Быстро", @"Очень быстро", nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    segmentedControl.frame = CGRectMake(20.0, 200.0, CGRectGetWidth(self.view.bounds) - 40.0, 50.0);
    [segmentedControl addTarget:self action:@selector(mySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
    segmentedControl.tintColor = [UIColor colorWithRed:3.0/255.0 green:145.0/255.0 blue:69.0/255.0 alpha:1];
    segmentedControl.selectedSegmentIndex = 0;
    [self.view addSubview:segmentedControl];
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    subTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
      [titleLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:60.0],
      [titleLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
      [titleLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
      [titleLabel.heightAnchor constraintEqualToConstant:50.0],
      
      [subTitleLabel.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant: 20.0],
      [subTitleLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20.0],
      [subTitleLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20.0],
     ]];
}


#pragma mark - Actions

- (void)mySegmentControlAction:(UISegmentedControl *)segment
{
    if(segment.selectedSegmentIndex == 0)
    {
        NSLog(@"00000");
    }
}


@end
