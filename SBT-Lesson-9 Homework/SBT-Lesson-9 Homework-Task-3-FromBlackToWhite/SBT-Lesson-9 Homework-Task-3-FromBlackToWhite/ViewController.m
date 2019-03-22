//
//  ViewController.m
//  SBT-Lesson-9 Homework-Task-3-FromBlackToWhite
//
//  Created by Dmitry Shapkin on 20/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint pointOnMainView = [touch locationInView:self.view];
    CGFloat coordinateX = pointOnMainView.x;
    CGFloat translateCoordinateX = coordinateX / self.view.frame.size.width;
    
    NSLog(@"%f", translateCoordinateX);
    
    self.view.backgroundColor = [UIColor colorWithRed:translateCoordinateX green:translateCoordinateX blue:translateCoordinateX alpha:1];
}

@end
