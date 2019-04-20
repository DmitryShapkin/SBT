//
//  DSPhotoCollectionViewCell.h
//  SBT-Lesson-21 SberPoisk
//
//  Created by Dmitry Shapkin on 19/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


@import UIKit;

@class DSPhoto;


NS_ASSUME_NONNULL_BEGIN

@interface DSPhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) DSPhoto *photo;

@end

NS_ASSUME_NONNULL_END
