//
//  SettingsViewController.h
//  SberPong
//
//  Created by Dmitry Shapkin on 08/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


@import UIKit;


NS_ASSUME_NONNULL_BEGIN

@protocol SegmentedControlDelegate <NSObject>

- (void)changeSpeed:(NSInteger)speedLevel;

@end


@interface SettingsViewController : UIViewController

@property (nonatomic, weak) id <SegmentedControlDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
