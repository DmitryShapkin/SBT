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
     За следующую строчку большое спасибо Артему Балашову.
     [[UIApplication sharedApplication].keyWindow addSubview:self.view];
     Без этого ключевого момента я бы точно не дошел до этого решения.
     
     Я несколько часов пытался вывести на экран self.view, но безуспешно.
     Постоянно был черный экран (self.window) и все мои попытки были тщетны,
     но благодаря его подсказке я пришел, на мой взгляд, к правильному решению.
     
     В решении Артема есть небольшой нюанс:
     Debug View Hierarchy отображает все элементы этого ViewController'а на одной плоскости и прямо в UIWindow
     
     Поэтому я подкорректировал глубину расположения нашей self.view
     Если посмотреть как выглядит иерархия вьюх до того как мы "заниялем" self.view, то увидим следующее:
     
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
    
    /**
     Проверяем расстановку вьюх в Debug View Hierarchy. Все отлично, все стоит на своих местах.
     Practice makes perfect.
     */
}


@end
