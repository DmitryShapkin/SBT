//
//  Grandson.m
//  SBT-Lesson-3-Homework
//
//  Created by Dmitry Shapkin on 02/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

#import "Grandson.h"

@implementation Grandson

#pragma mark - BorschDelegate

- (BOOL)borshServed
{
    // принять решение есть ли борщ (например, проверить, что текущее время от 14:00 до 16:00)
    // есть борщ при соблюдении условия
    // сообщить нужно ли мыть посуду, если борщ был съеден

    NSInteger currentHour = [self currentHour];
    NSInteger lunchStart = 14;
    NSInteger lunchFinish = 16;

    if (currentHour >= lunchStart && currentHour < lunchFinish ) {
        NSLog(@"Время обеда! Внучок пошел есть борщ.");
        return YES;
    } else if (currentHour < lunchStart) {
        NSLog(@"Время обеда еще не наступило, немного подождем");
        return NO;
    } else {
        NSLog(@"Время обеда уже прошло");
        return NO;
    }
}

- (NSInteger)currentHour
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour fromDate:now];
    
    return [components hour];
}

@end
