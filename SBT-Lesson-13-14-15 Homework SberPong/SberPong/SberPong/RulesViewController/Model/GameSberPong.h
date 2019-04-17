//
//  GameSberPong.h
//  SberPong
//
//  Created by Dmitry Shapkin on 17/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


@import UIKit;
@import Foundation;


NS_ASSUME_NONNULL_BEGIN

@interface GameSberPong : NSObject

@property (nonatomic, assign) NSInteger scoreTop;
@property (nonatomic, assign) NSInteger scoreBottom;
@property (nonatomic, assign) NSInteger maxScore;
@property (nonatomic, assign) CGFloat dx;
@property (nonatomic, assign) CGFloat dy;
@property (nonatomic, assign) CGFloat speed;

- (NSInteger)gameOver;
- (void)resetDirection;

@end

NS_ASSUME_NONNULL_END
