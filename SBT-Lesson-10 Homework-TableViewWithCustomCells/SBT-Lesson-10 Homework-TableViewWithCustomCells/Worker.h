//
//  Worker.h
//  SBT-Lesson-10 Homework-TableViewWithCustomCells
//
//  Created by Dmitry Shapkin on 20/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Worker : NSObject

@property (nonatomic, strong) UIImage *photoImage;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *profession;

@end

NS_ASSUME_NONNULL_END
