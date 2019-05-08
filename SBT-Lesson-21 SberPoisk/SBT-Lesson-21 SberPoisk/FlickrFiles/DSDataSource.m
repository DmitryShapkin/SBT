//
//  FlickrDataSource.m
//  SBT-Lesson-21 SberPoisk
//
//  Created by Dmitry Shapkin on 19/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "DSDataSource.h"
#import "DSFlickrClient.h"
#import "DSPhoto.h"
#import "DSPhotoCollectionViewCell.h"
#import "DSImageViewController.h"


NSString *const DSCellIdentifier = @"DSCellIdentifier";

@interface DSDataSource () <DSFlickrClientDelegate>

/** Клиент для загрузки результатов поиска Фликра */
@property (nonatomic, strong) DSFlickrClient *client;

/** Поисковый запрос */
@property (nonatomic, copy) NSString *query;

/** Возвращаем YES когда загружаем "новую страницу" */
@property (nonatomic, assign) BOOL isLoading;

/** Последняя запрошенная страница */
@property (nonatomic, assign) int lastLoadedPage;

@property (nonatomic, assign, readonly) CGFloat itemHeight;
@property (nonatomic, assign, readonly) CGFloat borderInset;
@property (nonatomic, assign, readonly) CGFloat itemWidth;

@end


@implementation DSDataSource

- (instancetype)initWithWidth:(CGFloat)width
{
    self = [super init];
    if (self)
    {
        _borderInset = 15;
        _itemWidth = (width - (3 * _borderInset)) / 2;
        _itemHeight = _itemWidth;
    }
    return self;
}

- (void)showPicturesWithQuery:(NSString *)query
{
    if (!self.client)
    {
        self.client = [[DSFlickrClient alloc] initWithDelegate:self];
    }
    
    self.photos = [NSMutableArray array];
    self.query = query;
    
    [self.collectionView reloadData];
    self.isLoading = YES;
    [self.client fetchWithQuery:self.query];
    self.lastLoadedPage = 1;
}


#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DSPhotoCollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:DSCellIdentifier
                                              forIndexPath:indexPath];
    
    if (indexPath.item < self.photos.count)
    {
        cell.photo = self.photos[indexPath.item];
    }
    
    if (indexPath.item == self.photos.count - 1)
    {
        /**
         Последний элемент-картинка на странице запускает загрузку новой страницы
         Спасибо stackoverflow ^_^
         */
        if (self.query.length && !self.isLoading)
        {
            self.isLoading = YES;
            self.lastLoadedPage++;
            [self.client fetchWithQuery:self.query page:self.lastLoadedPage];
        }
    }
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize itemSize = CGSizeMake(self.itemWidth, self.itemHeight);
    return itemSize;
}

- (void)didReceiveSearchResults:(NSMutableArray<DSPhoto *> *)results
{
        self.isLoading = NO;
        NSMutableArray<NSIndexPath *> *indexPaths = [NSMutableArray array];
        for (int i = (int)self.photos.count; i < self.photos.count + results.count; ++i)
        {
            NSIndexPath *path = [NSIndexPath indexPathForItem:i inSection:0];
            [indexPaths addObject:path];
        }
        
        [self.photos addObjectsFromArray:results];
        [self.collectionView insertItemsAtIndexPaths:indexPaths];
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *imageURL = self.photos[indexPath.item].url;
    [self.delegate pushViewControllerWithImageUrl:imageURL];
}

@end
