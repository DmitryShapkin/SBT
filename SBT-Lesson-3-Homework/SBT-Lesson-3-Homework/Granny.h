//
//  Granny.h
//  SBT-Lesson-3-Homework
//
//  Created by Dmitry Shapkin on 02/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BorschDelegate.h"

/**
 Класс, представляющий бабушку, которая может накормить любого человека,
 умеющего взаимодействовать с борщом, и помыть за ним посуду.
 */
@interface Granny : NSObject

@property (nonatomic, weak, nullable) id<BorshDelegate> borshDelegate;    /**< текущий делегат бабушки, которому будет предложено отведать борщ */

/**
 Приготовить и подать обед.
 */
- (void)serveLunch;

@end
