//
//  GameViewController.h
//  SberPong
//
//  Created by Dmitry Shapkin on 08/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


@import UIKit;

#import "SberPongTableView.h"
#import "SettingsViewController.h"
#import "PresenterSberPong.h"
#import "SberPongProtocols.h"

@class PresenterSberPong;


@interface SberPongMainView : UIViewController <StartNewGameProtocol, SberPongViewProtocol>

@property (nonatomic, strong) PresenterSberPong *presenter;
@property (nonatomic, strong) SberPongTableView *greenTableView;
@property (nonatomic, strong) NSTimer * timer;

- (void)createUserInterface;
- (void)flipTable:(SberPongTableView*)table;

@end
