//
//  PresenterSberPong.h
//  SberPong
//
//  Created by Dmitry Shapkin on 17/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


@import Foundation;

#import "GameSberPong.h"
#import "SberPongMainView.h"
#import "SberPongProtocols.h"

@class SberPongMainView;


NS_ASSUME_NONNULL_BEGIN

@interface PresenterSberPong : NSObject <SberPongPresenterProtocol>

@property (nonatomic, strong) GameSberPong *game;
@property (nonatomic, strong) SberPongMainView *view;

- (instancetype)initWithView:(SberPongMainView *)view model:(GameSberPong *)model;

@end

NS_ASSUME_NONNULL_END
