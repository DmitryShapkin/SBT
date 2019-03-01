//
//  BorschDelegate.h
//  SBT-Lesson-3-Homework
//
//  Created by Dmitry Shapkin on 01/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


/**
 Протокол делегирования "работы" по поеданию приготовленного борща.
 */
@protocol BorshDelegate <NSObject>

@optional

/**
 Оповещает о том, что борщ приготовлен и необходимо принять решение
 есть его или не есть.
 
 @return признак был съеден борщ или нет.
 */
- (BOOL)borshServed;

@end
