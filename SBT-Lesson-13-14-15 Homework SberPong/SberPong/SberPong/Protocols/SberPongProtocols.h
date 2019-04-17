//
//  SberPongProtocols.h
//  SberPong
//
//  Created by Dmitry Shapkin on 17/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


@import Foundation;


NS_ASSUME_NONNULL_BEGIN

@protocol SberPongViewProtocol <NSObject>

- (void)newGame;
- (void)createUserInterface;
- (void)setupSberPongTable;
- (void)setupPauseButton;
- (void)pauseButtonPressed:(UIButton*)button;
- (void)flipTable:(SberPongTableView*)table;
- (void)setAllItemsInTabBar:(UITabBarController *)aTabBar toEnableState:(BOOL)enableState;

@end


@protocol SberPongPresenterProtocol <NSObject>

- (void)showUserInterface;
- (void)startStopGameProcess;
- (void)startTimer;
- (void)moveBall;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
