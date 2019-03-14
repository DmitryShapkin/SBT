//
//  ViewController.m
//  SBT-Lesson-6 Runtime ObjC Swift
//
//  Created by Dmitry Shapkin on 12/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

#import "ViewController.h"
#import "DSObject.h"
#import "DSObjectChild.h"
#import "Man.h"
#import <objc/message.h> // For using class_ methods

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DSObject* object = [DSObject new];
    object.name = @"Dmitry";
    
    

    [object performSelector:@selector(doSomething)];
    
    DSObjectChild* child = [DSObjectChild new];
    
    //NSLog(@"%d", class_get_instance_size ([DSObjectChild class]));
    
    // Some practice from Ray Wenderlich
    
    Class myClass = [object class];
    
    // Return the super class
    NSLog(@"%@", class_getSuperclass([object class]));
    
    // Return the version of a class
    NSLog(@"%i", class_getVersion(myClass));
    NSLog(@"%i", class_getVersion([object class]));
    
    // Return the name of a class
    NSLog(@"%s", class_getName([object class]));
    
    /**
     Create an object in another way
     */
    
    DSObjectChild* newChild = objc_msgSend([child class], @selector(new));
    
    objc_msgSend(newChild, @selector(someFunction));
    
    // The same as above
    //[newChild someFunction];
    
    

    
    NSLog(@"Finish");
}


@end
