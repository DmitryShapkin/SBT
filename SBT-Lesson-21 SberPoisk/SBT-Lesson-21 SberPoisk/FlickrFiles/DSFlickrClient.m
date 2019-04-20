//
//  DSFlickrClient.m
//  SBT-Lesson-21 SberPoisk
//
//  Created by Dmitry Shapkin on 19/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "DSFlickrClient.h"
#import "DSPhoto.h"


static NSString *const kFlickrURL =
@"https://api.flickr.com/services/rest/"
@"?method=flickr.photos.search&api_key=9a74377d020533c1e2ee522a3481f6f3&text=%@&extras=url_s&"
@"format=json&nojsoncallback=1&page=%@";


@implementation DSFlickrClient

- (instancetype)initWithDelegate:(id<DSFlickrClientDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        _delegate = delegate;
    }
    return self;
}

- (void)fetchWithQuery:(NSString *)query
{
    [self fetchWithQuery:query page:1];
}

- (void)fetchWithQuery:(NSString *)query page:(int)page
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *pageString = [NSString stringWithFormat:@"%d", page];
        NSString *urlString = [NSString stringWithFormat:kFlickrURL, query, pageString];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        NSError *error;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:kNilOptions
                                                                      error:&error];
        if (error)
        {
            // TODO: Обработать ошибку
            return;
        }
        
        NSArray<NSDictionary *> *photos = json[@"photos"][@"photo"];
        
        NSMutableArray<DSPhoto *> *searchResults = [NSMutableArray array];
        for (NSDictionary *photoJson in photos)
        {
            NSString *url = photoJson[@"url_s"];
            DSPhoto *photo = [[DSPhoto alloc] initWithURL:url];
            photo.width = [photoJson[@"width_s"] doubleValue];
            photo.height = [photoJson[@"height_s"] doubleValue];
            [searchResults addObject:photo];
        }
        
        [self.delegate didReceiveSearchResults:searchResults];
    });
}

@end
