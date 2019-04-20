//
//  DSFlickrClient.h
//  SBT-Lesson-21 SberPoisk
//
//  Created by Dmitry Shapkin on 19/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


@import Foundation;


NS_ASSUME_NONNULL_BEGIN

@class DSPhoto;


@protocol DSFlickrClientDelegate

/** Данный метод вызывается когда доступна новая страница с результатами поиска */
- (void)didReceiveSearchResults:(NSMutableArray<DSPhoto *> *)results;

@end

/** Собираем данные с API Фликра */
@interface DSFlickrClient : NSObject

@property (nonatomic, weak, readonly) id<DSFlickrClientDelegate> delegate;

- (instancetype)initWithDelegate:(id<DSFlickrClientDelegate>)delegate;

- (void)fetchWithQuery:(NSString *)query;
- (void)fetchWithQuery:(NSString *)query page:(int)page;

@end

NS_ASSUME_NONNULL_END
