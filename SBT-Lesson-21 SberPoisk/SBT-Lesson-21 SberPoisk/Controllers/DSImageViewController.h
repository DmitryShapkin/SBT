//
//  DSImageViewController.h
//  SBT-Lesson-21 SberPoisk
//
//  Created by Dmitry Shapkin on 19/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


@import UIKit;


NS_ASSUME_NONNULL_BEGIN

@interface DSImageViewController : UIViewController

@property (nonatomic, copy) NSString *imageURL;

- (void)setImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
