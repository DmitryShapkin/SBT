//
//  CustomTableViewCellOne.m
//  SBT-Lesson-10 Homework-TableViewWithCustomCells
//
//  Created by Dmitry Shapkin on 20/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

#import "CustomTableViewCellOne.h"

@interface CustomTableViewCellOne ()

@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, assign) CGFloat coverImageSide;
@property (nonatomic, strong) UIView *boxView;

@end

@implementation CustomTableViewCellOne

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.coverImageSide = 90.f;
        self.offset = 15.f;
        
        _coverImageView = [UIImageView new];
        _coverImageView.layer.cornerRadius = self.coverImageSide / 2;
        _coverImageView.layer.masksToBounds = YES;
        _coverImageView.layer.borderWidth = 0;
        [self.contentView addSubview:_coverImageView];
        
        _boxView = [UIView new];
        [self.contentView addSubview:_boxView];
        
        _titleLabel = [UILabel new];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.boxView addSubview:_titleLabel];
        
        _subtitileLabel = [UILabel new];
        _subtitileLabel.textAlignment = NSTextAlignmentCenter;
        [self.boxView addSubview:_subtitileLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setupLayout];
}

- (void)setupLayout {
    
    self.coverImageView.frame = CGRectMake(CGRectGetWidth(self.contentView.frame) - self.coverImageSide - self.offset, self.offset, self.coverImageSide, self.coverImageSide);
    
    self.boxView.frame = CGRectMake(self.offset, self.offset, CGRectGetWidth(self.frame) - CGRectGetWidth(self.coverImageView.frame) - self.offset * 3, CGRectGetHeight(self.coverImageView.frame));
    
    self.titleLabel.frame = CGRectMake(0, self.offset, CGRectGetWidth(self.boxView.frame), 20.f);
    
    self.subtitileLabel.frame = CGRectMake(0, self.offset * 3, CGRectGetWidth(self.boxView.frame), 20.f);
}
@end
