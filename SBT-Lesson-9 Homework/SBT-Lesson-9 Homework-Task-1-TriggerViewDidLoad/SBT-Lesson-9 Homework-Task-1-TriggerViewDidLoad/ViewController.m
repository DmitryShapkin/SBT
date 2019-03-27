//
//  ViewController.m
//  SBT-Lesson-9 Homework-Task-1-TriggerViewDidLoad
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
    
    NSLog(@"viewDidLoad");
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [myButton addTarget:self action:@selector(triggerViewDidLoad) forControlEvents:UIControlEventTouchUpInside];
    [myButton setTitle:@"Trigger ViewDidLoad" forState:UIControlStateNormal];
    myButton.frame = CGRectMake(self.view.center.x - 100, self.view.center.y - 30, 200.0, 60.0);
    myButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:myButton];
}

- (void)triggerViewDidLoad
{
    NSLog(@"I'm triggering viewDidLoad");
    
    self.view = nil;
    
   /**
     - UIWindow (1)
     -- UINavigationController (2)
     --- UILayoutContainerView (3)
     ---- UINavigationTransitionView (4)
     ----- UIViewControllerWrapperView (5)
     ------ ViewController (наш вьюконтроллер)
     
     Исходя из этой иерархии нам необходимо поместить нашу self.view вглубь на 5 уровней.
     P.S. Для наглядности я пронумеровал каждый уровень.
     */

    // Уровень #1
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    // Уровень #2
    UIView *uiLayoutContainerView = [[window subviews] objectAtIndex:0];
    
    // Уровень #3
    UIView *uiNavigationTransitionView = [[uiLayoutContainerView subviews] objectAtIndex:0];
    
    // Уровень #4
    UIView *uiViewControllerWrapperView = [[uiNavigationTransitionView subviews] objectAtIndex:0];
    
    // Уровень #5
    [uiViewControllerWrapperView addSubview:self.view];
}


@end
