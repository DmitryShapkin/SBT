//
//  DSObjectChild.m
//  SBT-Lesson-6 Runtime ObjC Swift
//
//  Created by Dmitry Shapkin on 12/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

#import "DSObjectChild.h"
#import "Man.h"

@import ObjectiveC;

@implementation DSObjectChild

- (instancetype)init
{
    self = [super init];
    if (self) {
        Man* newMan = objc_msgSend([Man class], @selector(new));
    }
    return self;
}

- (void) someFunction {
    NSLog(@"Some Function");
}

@end
