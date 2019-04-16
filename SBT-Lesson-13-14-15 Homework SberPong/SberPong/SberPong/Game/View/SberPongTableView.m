//
//  SberPongTableView.m
//  SberPong
//
//  Created by Dmitry Shapkin on 08/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "SberPongTableView.h"
#import <QuartzCore/QuartzCore.h>
#import "SberPongColor.h"


@interface SberPongTableView ()

@end


@implementation SberPongTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout
{
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sberLogo.png"]];
    background.center = CGPointMake(self.center.x + 120.0, self.center.y + 80.0);
    background.alpha = 0.1;
    [self addSubview:background];
    
    [self addShadow];
    
    [self drawScoreTop];
    [self drawScoreBottom];
    [self drawBall];
    [self drawPaddleTop];
    [self drawPaddleBottom];
    [self drawMessageView];
}

- (void)drawRect:(CGRect)rect
{
    [self drawTableMarkup];
}


#pragma mark - Drawings

- (void)addShadow
{
    self.layer.shadowRadius = 7.5f;
    self.layer.shadowColor = [SberPongColor shadowSberColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.layer.shadowOpacity = 0.9f;
    self.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets = UIEdgeInsetsMake(0, 0, -7.5f, 0);
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(self.bounds, shadowInsets)];
    self.layer.shadowPath = shadowPath.CGPath;
}

- (void)drawTableMarkup
{
    // Нарисуем разметку для стола нашего Сбер-Понга
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 6.f);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextMoveToPoint(context, CGRectGetMinX(self.bounds) + 8.f, CGRectGetMinY(self.bounds) + 8.f);
    CGContextAddLineToPoint(context, CGRectGetMinX(self.bounds) + 8.f, CGRectGetMaxY(self.bounds) - 8.f);
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds) - 8.f, CGRectGetMaxY(self.bounds) - 8.f);
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds) - 8.f, CGRectGetMinY(self.bounds) + 8.f);
    CGContextAddLineToPoint(context, CGRectGetMinX(self.bounds) + 8.f, CGRectGetMinY(self.bounds) + 8.f);
    CGContextMoveToPoint(context, CGRectGetMinX(self.bounds) + 8.f, CGRectGetMidY(self.bounds));
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds) - 8.f, CGRectGetMidY(self.bounds));
    CGContextStrokePath(context);
}

- (void)drawScoreTop
{
    self.scoreTop = [UILabel new];
    self.scoreTop.alpha = 0.7f;
    self.scoreTop.textColor = [UIColor whiteColor];
    self.scoreTop.text = @"0";
    self.scoreTop.font = [UIFont systemFontOfSize: 120.0 weight:UIFontWeightLight];
    self.scoreTop.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.scoreTop];
    
    self.scoreTop.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
          [self.scoreTop.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
          [self.scoreTop.centerYAnchor constraintEqualToAnchor:self.topAnchor constant: self.bounds.size.height / 4],
    ]];
}

- (void)drawScoreBottom
{
    self.scoreBottom = [UILabel new];
    self.scoreBottom.alpha = 0.7f;
    self.scoreBottom.textColor = [UIColor whiteColor];
    self.scoreBottom.text = @"0";
    self.scoreBottom.font = [UIFont systemFontOfSize: 120.0 weight:UIFontWeightLight];
    self.scoreBottom.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.scoreBottom];
    
    self.scoreBottom.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
          [self.scoreBottom.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
          [self.scoreBottom.centerYAnchor constraintEqualToAnchor:self.bottomAnchor constant: -self.bounds.size.height / 4],
    ]];
}

- (void)drawBall
{
    self.ball = [UIView new];
    self.ball.backgroundColor = [SberPongColor orangeSberColor];
    self.ball.layer.cornerRadius = 10.f;
    self.ball.hidden = YES;
    [self addSubview:self.ball];
    
    self.ball.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
          [self.ball.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
          [self.ball.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
          [self.ball.widthAnchor constraintEqualToConstant:20.f],
          [self.ball.heightAnchor constraintEqualToConstant:20.f],
    ]];
}

- (void)drawPaddleTop
{
    self.paddleTop = [[UIView alloc] initWithFrame:CGRectMake(40, 16, 90, 20)];
    self.paddleTop.backgroundColor = [SberPongColor redSberColor];
    [self addSubview: self.paddleTop];
    
    /**
     Задать вопрос Лёше по этому куску кода (при новой игре - верхняя ракетка стартует из центра) - готово
     
     self.paddleTop.translatesAutoresizingMaskIntoConstraints = NO;
     [NSLayoutConstraint activateConstraints:@[
        [self.paddleTop.topAnchor constraintEqualToAnchor:self.topAnchor constant: 16.f],
        [self.paddleTop.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.paddleTop.widthAnchor constraintEqualToConstant:90.f],
        [self.paddleTop.heightAnchor constraintEqualToConstant:20.f],
     ]];
     
     */
}

- (void)drawPaddleBottom
{
    self.paddleBottom = [[UIView alloc] initWithFrame:CGRectMake(40, self.bounds.size.height - 36, 90, 20)];
    self.paddleBottom.backgroundColor = [SberPongColor redSberColor];
    [self addSubview:self.paddleBottom];
    
    /**
     Задать вопрос Лёше по этому куску кода (при новой игре - нижняя ракетка стартует из центра) - готово
     
     self.paddleBottom.translatesAutoresizingMaskIntoConstraints = NO;
     [NSLayoutConstraint activateConstraints:@[
        [self.paddleBottom.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant: -16.f],
        [self.paddleBottom.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.paddleBottom.widthAnchor constraintEqualToConstant:90.f],
        [self.paddleBottom.heightAnchor constraintEqualToConstant:20.f],
     ]];
     */
}

- (void)drawMessageView
{
    self.messageView = [[UIView alloc] initWithFrame:self.bounds];
    self.messageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"greenLines"]];

    UIButton *startNewGameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [startNewGameButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:20.0]];
    [startNewGameButton.titleLabel setTextColor:[UIColor whiteColor]];
    startNewGameButton.contentEdgeInsets = UIEdgeInsetsMake(20, 30, 20, 30);
    startNewGameButton.backgroundColor = [SberPongColor darkGreenSberColor];
    startNewGameButton.layer.cornerRadius = 32.f;
    
    [startNewGameButton setTitle:@"Начать новую игру" forState:UIControlStateNormal];
    [startNewGameButton addTarget:self action:@selector(startNewGame) forControlEvents:UIControlEventTouchUpInside];
    [startNewGameButton sizeToFit];
    startNewGameButton.center = self.messageView.center;
    
    // Добавим тень кнопке
    startNewGameButton.layer.shadowRadius = 30.f;
    startNewGameButton.layer.shadowColor = [UIColor blackColor].CGColor;
    startNewGameButton.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    startNewGameButton.layer.shadowOpacity = 0.9f;
    startNewGameButton.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets = UIEdgeInsetsMake(0, 0, -0.5f, 0);
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(startNewGameButton.bounds, shadowInsets)];
    startNewGameButton.layer.shadowPath = shadowPath.CGPath;

    [self.messageView addSubview:startNewGameButton];
    [self addSubview:self.messageView];
}

- (void)startNewGame
{
    [self.delegate newGame];
}

@end
