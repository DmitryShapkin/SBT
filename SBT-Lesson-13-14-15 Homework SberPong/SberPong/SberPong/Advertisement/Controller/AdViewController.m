//
//  AdViewController.m
//  SberPong
//
//  Created by Dmitry Shapkin on 12/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "AdViewController.h"


@interface AdViewController ()

@end


@implementation AdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *lightGraySberColor = [UIColor colorWithRed:240.0/255.0 green:243.0/255.0 blue:252.0/255.0 alpha:1];
    self.view.backgroundColor = lightGraySberColor;
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"Реклама";
    titleLabel.textColor = [UIColor colorWithRed:13.0/255.0 green:10.0/255.0 blue:37.0/255.0 alpha:1];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:22]];
    [self.view addSubview:titleLabel];
    
    UILabel *subTitleLabel = [UILabel new];
    subTitleLabel.text = @"Открыта регистрация на Зелёный Марафон! Бежим со смыслом — 1 июня, в День защиты детей. В Москве для участия в Зелёном Марафоне «Бегущие Сердца» нужно сделать взнос. Все деньги мы отправим в благотворительный фонд «Обнажённые сердца», на помощь детям.\n\nРегистрация — на https://runninghearts.ru/?register_2019. В остальных регионах участие бесплатное. Регистрируйтесь на https://greenmarathon.ru/\n\nУчастникам «Зелёного Марафона», в зависимости от города проведения, будут предложены три дистанции: 4.2, 10, 21.1 км. Впервые в соревновательной программе во всех городах-участниках состоятся детские забеги на разные расстояния для юных спортсменов от 7 до 13 лет.";
    subTitleLabel.textColor = [UIColor colorWithRed:125.0/255.0 green:129.0/255.0 blue:140.0/255.0 alpha:1];
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    subTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    subTitleLabel.numberOfLines = 0;
    [subTitleLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
    
    [self.view addSubview:subTitleLabel];

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

@end
