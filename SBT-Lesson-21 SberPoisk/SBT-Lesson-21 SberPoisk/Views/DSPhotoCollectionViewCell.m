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
    CGFloat imageOffset = 30.f;
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView.trackTintColor = [SberColor darkGreenSberColor];
    self.progressView.frame = CGRectMake(imageOffset, self.center.y - imageOffset/2, CGRectGetWidth(self.frame) - imageOffset * 2, imageOffset);
    [self addSubview:self.progressView];
}

- (void)setPhoto:(DSPhoto *)photo
{
    self.progressView.hidden = NO;
    _photo = photo;
    if (!photo || !photo.url.length)
    {
        return;
    }
    DSPhoto *oldPhoto = photo;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:photo.url]];
        if (!data)
        {
            // TODO: Показать сообщение об ошибке
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (oldPhoto == self.photo)
            {
                self.imageView.image = [UIImage imageWithData:data];
                self.progressView.hidden = YES;
            }
        });
    });
}

- (void)prepareForReuse
{
    _photo = nil;
    _imageView.image = nil;
    [super prepareForReuse];
}

@end
