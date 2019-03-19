//
//  ViewController.m
//  ObjectiveC-with-Swift-file
//
//  Created by Dmitry Shapkin on 18/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

#import "ViewController.h"
#import "ObjectiveCWithSwiftFile-Swift.h"

@interface ViewController ()

- (LinkedListForObjC *)createLinkedListSwift;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // In bulid settings of project:
    // 1. Changed "Defines Module" to YES
    // 2. Set "Product Module Name" to ObjectiveCWithSwift-file (name of project without "-")
    // 3. Import automatic generated Swift file (line 10)
    
    MySwiftClass *myClass = [MySwiftClass new];
    [myClass doSomething];
    
    LinkedListForObjC *linkedList = [self createLinkedListSwift];
    
    [linkedList append:@"Москва"];
    [linkedList append:@"Санкт-Петербург"];
    [linkedList append:@"Нью-Йорк"];
    [linkedList append:@"Майами"];
    [linkedList append:@"Пало Альто"];
    
    NSLog(@"%@", linkedList[0]);
    NSLog(@"%@", linkedList[2]);
    
    NSLog(@"%ld", [linkedList count]);
    
    NSLog(@"HEAD: %@", [linkedList head]);
    NSLog(@"TAIL: %@", [linkedList last]);
}

- (LinkedListForObjC *)createLinkedListSwift {
    LinkedListForObjC *linkedList = [LinkedListForObjC new];
    return linkedList;
}

@end
