//
//  SberPongTableView.m
//  SberPong
//
//  Created by Dmitry Shapkin on 08/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "SberPongTableView.h"


@interface SberPongTableView ()

@property (nonatomic, assign) CGFloat touchOffset;

@end


@implementation SberPongTableView

- (void)drawRect:(CGRect)rect
{
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sberLogo.png"]];
    background.center = CGPointMake(self.center.x + 120.f, self.center.y + 80.f);
    background.alpha = 0.1f;
    self.layer.masksToBounds = YES;
    [self addSubview:background];
    
    [self drawTableMarkup];
    [self drawScoreTop];
    [self drawScoreBottom];
    [self drawBall];
    [self drawPaddleTop];
    [self drawPaddleBottom];
}

- (void)drawTableMarkup
{
    // Нарисуем разметку для стола нашего Сбер-Понга
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 6.f);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextMoveToPoint(context, CGRectGetMinX(self.bounds) + 8.f,
                         CGRectGetMinY(self.bounds) + 8.f);
    CGContextAddLineToPoint(context, CGRectGetMinX(self.bounds) + 8.f,
                            CGRectGetMaxY(self.bounds) - 8.f);
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds) - 8.f,
                            CGRectGetMaxY(self.bounds) - 8.f);
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds) - 8.f,
                            CGRectGetMinY(self.bounds) + 8.f);
    CGContextAddLineToPoint(context, CGRectGetMinX(self.bounds) + 8.f,
                            CGRectGetMinY(self.bounds) + 8.f);
    CGContextMoveToPoint(context, CGRectGetMinX(self.bounds) + 8.f,
                         CGRectGetMidY(self.bounds));
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds) - 8.f,
                            CGRectGetMidY(self.bounds));
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
    self.scoreTop.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.scoreTop];
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
    UIColor *orangeSberColor = [UIColor colorWithRed:255.0/255.0 green:168.0/255.0 blue:3.0/255.0 alpha:1];
    self.ball = [UIView new];
    self.ball.backgroundColor = orangeSberColor;
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
    self.paddleTop.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:85.0/255.0 blue:83.0/255.0 alpha:1];
    [self addSubview: self.paddleTop];
    
    /**
     Задать вопрос Лёше по этому куску кода (при новой игре - верхняя ракетка стартует из центра)
     
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
    self.paddleBottom.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:85.0/255.0 blue:83.0/255.0 alpha:1];
    [self addSubview: self.paddleBottom];
    
    /**
     Задать вопрос Лёше по этому куску кода (при новой игре - нижняя ракетка стартует из центра)
     
     self.paddleBottom.translatesAutoresizingMaskIntoConstraints = NO;
     [NSLayoutConstraint activateConstraints:@[
        [self.paddleBottom.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant: -16.f],
        [self.paddleBottom.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.paddleBottom.widthAnchor constraintEqualToConstant:90.f],
        [self.paddleBottom.heightAnchor constraintEqualToConstant:20.f],
     ]];
     */
}

@end
