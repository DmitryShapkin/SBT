//
//  ViewController.m
//  SBT-Lesson-9 Homework-Task-1-TriggerViewDidLoad
//
//  Created by Dmitry Shapkin on 20/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UINavigationControllerDelegate>

@property (strong, nonatomic) UIView *myView;

@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"init");
    }
    return self;
}

- (void)loadView {
    [super loadView];
    //self.myView = self.view;
    

    
    [self loadViewIfNeeded];
    
    NSLog(@"loadView");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", self.view.hidden ? @"TRUE" : @"FALSE");
    
    //[self.view bringSubviewToFront:self];
    
//    NSLog(@"viewDidLoad - %@", [[self navigationController] viewControllers]);
//    NSLog(@"viewDidLoad visible - %@", [[self navigationController] visibleViewController]);
//
    NSLog(@"viewDidLoad");
    
    NSLog(@"%@", NSStringFromCGRect(self.view.bounds) );
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [myButton addTarget:self action:@selector(triggerViewDidLoad) forControlEvents:UIControlEventTouchUpInside];
    [myButton setTitle:@"Trigger ViewDidLoad" forState:UIControlStateNormal];
    myButton.frame = CGRectMake(self.view.center.x - 100, self.view.center.y - 30, 200.0, 60.0);
    myButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:myButton];
    
    
    NSLog(@"End of viewDidLoad");
    
    //[self.view layoutIfNeeded];
}

- (void)viewWillLayoutSubviews {
    NSLog(@"viewWillLayoutSubviews");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    [self.view layoutIfNeeded];
    [self.view layoutSubviews];
    
    NSLog(@"viewWillAppear");
}

- (void)triggerViewDidLoad {
    NSLog(@"I'm triggering viewDidLoad");
    
//    NSLog(@"1 - %@", [[self navigationController] viewControllers]);
//
//    [[self navigationController] popToViewController:self animated:YES];
//
//    NSLog(@"2 - %@", [[self navigationController] viewControllers]);
    
    
    self.view = nil;
    

    
//    UIViewController *vc = [[ViewController alloc] init];
//    [[self navigationController] pushViewController:vc animated:YES];
    
//    self.view;
    
    //self.view = self.myView;
//
//    NSLog(@"something");
//
    NSLog(@"%@", [[self navigationController] topViewController]);
//
//
//
//
    self.view.backgroundColor = [UIColor greenColor];
    
    
}

- (void)dealloc
{
    NSLog(@"dealloc");
}






#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"HERE");
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"HERE2");
}



@end


