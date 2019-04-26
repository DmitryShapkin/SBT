//
//  FlickrDataSource.h
//  SBT-Lesson-21 SberPoisk
//
//  Created by Dmitry Shapkin on 19/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


@import UIKit;
@import Foundation;

#import "DSPhoto.h"


@protocol CollectionViewItemDelegate <NSObject>

- (void)pushViewControllerWithImageUrl:(NSString *)url;

@end


NS_ASSUME_NONNULL_BEGIN

extern NSString *const DSCellIdentifier;

/** Обрабатываем контент для CollectionView */
@interface DSDataSource : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>

/** Массив картинок, которые будут показаны в CollectionView */
@property (nonatomic, strong) NSMutableArray<DSPhoto *> *photos;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) id<CollectionViewItemDelegate> delegate;

- (instancetype)initWithWidth:(CGFloat)width;
- (void)showPicturesWithQuery:(NSString *)query;

@end

NS_ASSUME_NONNULL_END
