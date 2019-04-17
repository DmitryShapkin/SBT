//
//  SberPongAssembly.m
//  SberPong
//
//  Created by Dmitry Shapkin on 17/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "SberPongAssembly.h"
#import "GameSberPong.h"
#import "SberPongMainView.h"
#import "PresenterSberPong.h"

@implementation SberPongAssembly

+ (UIViewController *)assemblySberPong {
    GameSberPong *game = [GameSberPong new];
    SberPongMainView *view = [SberPongMainView new];
    PresenterSberPong *presenter = [[PresenterSberPong alloc] initWithView:view model:game];
    view.presenter = presenter;
    return view;
}

@end
