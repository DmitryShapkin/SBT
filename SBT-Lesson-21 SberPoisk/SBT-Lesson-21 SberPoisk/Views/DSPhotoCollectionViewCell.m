//
//  DSPhotoCollectionViewCell.m
//  SBT-Lesson-21 SberPoisk
//
//  Created by Dmitry Shapkin on 19/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "DSPhotoCollectionViewCell.h"
#import "DSPhoto.h"
#import "SberColor.h"


@interface DSPhotoCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) DSPhoto *oldPhoto;

@end


@implementation DSPhotoCollectionViewCell

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _imageView = [[UIImageView alloc] init];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.masksToBounds = YES;
        _imageView.backgroundColor = [SberColor superLightGraySberColor];
        _imageView.layer.cornerRadius = 10.f;
        [self addSubview:_imageView];
        [NSLayoutConstraint activateConstraints:@[
              [self.centerXAnchor constraintEqualToAnchor:_imageView.centerXAnchor],
              [self.centerYAnchor constraintEqualToAnchor:_imageView.centerYAnchor],
              [self.leadingAnchor constraintEqualToAnchor:_imageView.leadingAnchor],
              [self.trailingAnchor constraintEqualToAnchor:_imageView.trailingAnchor],
              [self.topAnchor constraintEqualToAnchor:_imageView.topAnchor],
              [self.bottomAnchor constraintEqualToAnchor:_imageView.bottomAnchor]
        ]];
        
        [self setupProgressView];
    }
    return self;
}

- (void)setupProgressView
{
    CGFloat progressViewOffset = 10.f;
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView.progressTintColor = [SberColor darkGreenSberColor];
    self.progressView.trackTintColor = [SberColor graySberColor];
    self.progressView.frame = CGRectMake(progressViewOffset, CGRectGetMidY(self.bounds), CGRectGetWidth(self.bounds) - progressViewOffset * 2, 20);
    CATransform3D transform = CATransform3DScale(self.progressView.layer.transform, 1.0f, 5.0f, 1.0f);
    self.progressView.layer.transform = transform;
    self.progressView.layer.cornerRadius = 10;
    self.progressView.clipsToBounds = true;
    [self addSubview:self.progressView];
}

- (void)setPhoto:(DSPhoto *)photo
{
    self.progressView.hidden = NO;
    _photo = photo; /**< используем iVar, потому что Сеттер, иначе будет цикл */
    
    if (!photo || !photo.url.length)
    {
        return;
    }
    self.oldPhoto = photo;
    
    /** Магия для progressView */
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:[NSURL URLWithString:photo.url]];
    
    /**
     Для теста прогресс-бара - большая картинка:
     NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:[NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/4/4e/Pleiades_large.jpg"]];
     */
    [downloadTask resume];
}

- (void)prepareForReuse
{
    _photo = nil;
    _imageView.image = nil;
    [super prepareForReuse];
}

#pragma mark - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.oldPhoto.url]];
        if (!data)
        {
            // TODO: Показать сообщение об ошибке
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.oldPhoto == self.photo)
            {
                self.imageView.image = [UIImage imageWithData:data];
                self.progressView.hidden = YES;
            }
        });
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    double progress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.progressView setProgress:progress];
    });
}

@end
