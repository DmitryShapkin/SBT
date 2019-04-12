//
//  SberPongTableView.h
//  SberPong
//
//  Created by Dmitry Shapkin on 08/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


@import UIKit;


NS_ASSUME_NONNULL_BEGIN

@protocol StartNewGameProtocol <NSObject>

- (void)newGame;

@end


@interface SberPongTableView : UIView

@property (nonatomic, strong) UILabel *scoreTop;
@property (nonatomic, strong) UILabel *scoreBottom;
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIView *ball;
@property (nonatomic, strong) UIView *paddleTop;
@property (nonatomic, strong) UIView *paddleBottom;
@property (nonatomic, strong) UIView *messageView;
@property (nonatomic, assign) BOOL isFlipped;
@property (nonatomic, weak) id <StartNewGameProtocol> delegate;

@end

NS_ASSUME_NONNULL_END
