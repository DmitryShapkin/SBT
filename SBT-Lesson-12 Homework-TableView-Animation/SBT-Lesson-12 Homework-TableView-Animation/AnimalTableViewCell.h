//
//  AnimalTableViewCell.h
//  SBT-Lesson-12 Homework-TableView-Animation
//
//  Created by Dmitry Shapkin on 26/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface AnimalTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitileLabel;

@end

NS_ASSUME_NONNULL_END
