//
//  Granny.m
//  SBT-Lesson-3-Homework
//
//  Created by Dmitry Shapkin on 02/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

#import "Granny.h"

@implementation Granny

- (void)serveLunch
{
    // приготовить обед
    [self cookDinner];
    
    // переложить работу по употреблению обеда делегату
    
    if ([self.borshDelegate respondsToSelector:@selector(borshServed)]) {
        BOOL borschWasEaten = [self.borshDelegate borshServed];
        
        // проверить решение делегата
        // исходя из решения вызывает или не вызывает метод для мытья посуды
        if (borschWasEaten) {
            NSLog(@"Борщ был съеден и осталась грязная посуда.");
            [self washDishes];
        }
    }
}

- (void)washDishes
{
    // помыть посуду
    NSLog(@"Бабушка моет посуду");
}

- (void)cookDinner
{
    // приготовить обед
    NSLog(@"Внучок, обед готов!");
}

@end
