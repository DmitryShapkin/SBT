//
//  RussianFactory.m
//  ObjC-AbstractFactory
//
//  Created by Dmitry Shapkin on 21/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "RussianFactory.h"
#import "Mir.h"
#import "YandexPhone.h"


@implementation RussianFactory

- (nonnull id<BankCardProtocol>)produceBankCard
{
    NSLog(@"Создана карта Мир");
    return [Mir new];
}

- (nonnull id<PhoneProtocol>)producePhone
{
    NSLog(@"Создан Яндекс.Телефон");
    return [YandexPhone new];
}

@end
