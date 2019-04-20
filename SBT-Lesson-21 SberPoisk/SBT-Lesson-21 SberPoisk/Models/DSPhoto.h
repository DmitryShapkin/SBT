//
//  DSPhoto.h
//  SBT-Lesson-21 SberPoisk
//
//  Created by Dmitry Shapkin on 19/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


@import UIKit;
@import Foundation;


NS_ASSUME_NONNULL_BEGIN

/** Моделька для фотографии */
@interface DSPhoto : NSObject

/** URL картинки */
@property (nonatomic, readonly) NSString *url;

/** Ширина картинки */
@property (nonatomic, assign) CGFloat width;

/** Высота картинки */
@property (nonatomic, assign) CGFloat height;

- (instancetype)initWithURL:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
