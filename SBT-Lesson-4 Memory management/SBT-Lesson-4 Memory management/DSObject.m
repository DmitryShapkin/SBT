//
//  DSObject.m
//  SBT-Lesson-4 Memory management
//
//  Created by Dmitry Shapkin on 05/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

#import "DSObject.h"

@implementation DSObject
@synthesize name = _name;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"Default";
    }
    return self;
}

// Getters - another sample for using autorelease
- (NSString *)name {
    return [[_name retain] autorelease];
}

// Setter for name
- (void)setName:(NSString *)name {
    if (_name != name) {
        NSLog(@"Setter for name is called");
        NSLog(@"_name: %p", _name);
        NSLog(@"name: %p", name);
        
        [_name release]; // Освобождаем старый объект
        _name = [name retain]; // Увеличиваем счетчик ссылок на новый
        //объект и ставим на него указатель _name
    }
}

@end
