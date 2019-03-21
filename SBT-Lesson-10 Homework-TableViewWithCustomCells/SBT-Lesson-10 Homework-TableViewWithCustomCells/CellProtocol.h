//
//  CellProtocol.h
//  SBT-Lesson-10 Homework-TableViewWithCustomCells
//
//  Created by Dmitry Shapkin on 21/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CellProtocol <NSObject>

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitileLabel;

@end

NS_ASSUME_NONNULL_END
