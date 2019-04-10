//
//  SberPongTableView.h
//  SberPong
//
//  Created by Dmitry Shapkin on 08/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


@import UIKit;


NS_ASSUME_NONNULL_BEGIN

@interface SberPongTableView : UIView

@property (strong, nonatomic) UILabel *scoreTop;
@property (strong, nonatomic) UILabel *scoreBottom;
@property (strong, nonatomic) UIImageView *coverImageView;
@property (strong, nonatomic) UIView *ball;
@property (strong, nonatomic) UIView *paddleTop;
@property (strong, nonatomic) UIView *paddleBottom;

@end

NS_ASSUME_NONNULL_END
