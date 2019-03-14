//
//  ViewController.m
//  SBT-Lesson-4 Memory management
//
//  Created by Dmitry Shapkin on 05/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

#import "ViewController.h"
#import "DSObject.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize name = _name;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // Trying to print AutoreleasePool
    extern void _objc_autoreleasePoolPrint(void);
    _objc_autoreleasePoolPrint();

    
    // Create my own Autoreleasepool (crash)
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSObject *obj = [[NSObject new] autorelease];
    [pool drain];
//    NSLog(@"%@", obj); // Крэш обращаемся к удаленному объеку
    
    
    // New syntax (more secure)
    @autoreleasepool {
        NSObject *obj = [[NSObject new] autorelease];
    }
    //NSLog(@"%@",obj); // Ошибка компиляции
    
    
    // Big amount of temporary objects
    for (NSUInteger i=0; i<1000; ++i) {
        @autoreleasepool {
            NSObject *obj = [[NSObject new] autorelease];
            NSLog(@"%@ %@", @(i),obj);
        }
    }
    
    DSObject *object = [DSObject new];
    object.name = @"Dmitry";
    

    
}

// Getters - another sample for using autorelease
- (NSString *)name {
    return [[_name retain] autorelease];
}

// Setter for name
- (void)setName:(NSString *)name {
    if (_name != name) {
        NSLog(@"Setter for name is called");
        [_name release]; // Освобождаем старый объект
        _name = [name retain]; // Увеличиваем счетчик ссылок на новый
        //объект и ставим на него указатель _name
    }
}

@end
