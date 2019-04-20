//
//  DSPhoto.m
//  SBT-Lesson-21 SberPoisk
//
//  Created by Dmitry Shapkin on 19/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "DSPhoto.h"


@implementation DSPhoto

- (instancetype)initWithURL:(NSString *)url
{
    self = [super init];
    if (self)
    {
        _url = url;
    }
    return self;
}

@end
