//
//  AnimalTableViewCell.m
//  SBT-Lesson-12 Homework-TableView-Animation
//
//  Created by Dmitry Shapkin on 26/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "AnimalTableViewCell.h"


@interface AnimalTableViewCell ()

@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, assign) CGFloat coverImageSide;

@end


@implementation AnimalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.coverImageSide = 70.f;
        self.offset = 15.f;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        _coverImageView = [UIImageView new];
        _coverImageView.layer.cornerRadius = self.coverImageSide / 2;
        _coverImageView.layer.masksToBounds = YES;
        _coverImageView.layer.borderWidth = 0;
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_coverImageView];

        _titleLabel = [UILabel new];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
        
        _subtitileLabel = [UILabel new];
        _subtitileLabel.textAlignment = NSTextAlignmentCenter;
        _subtitileLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _subtitileLabel.numberOfLines = 0;
        [self.contentView addSubview:_subtitileLabel];
        
        [self setupLayout];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setupLayout
{
    self.coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.subtitileLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.coverImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:15],
        [self.coverImageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:15],
        [self.coverImageView.heightAnchor constraintEqualToConstant:70],
        [self.coverImageView.widthAnchor constraintEqualToConstant:70],
        
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:15],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.coverImageView.trailingAnchor constant:15],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-15],
        
        [self.subtitileLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor],
        [self.subtitileLabel.leadingAnchor constraintEqualToAnchor:self.coverImageView.trailingAnchor constant:15],
        [self.subtitileLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-15],
        [self.subtitileLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-15]
    ]];
}
@end
