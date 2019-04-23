//
//  EuropeanFactory.m
//  ObjC-AbstractFactory
//
//  Created by Dmitry Shapkin on 23/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "EuropeanFactory.h"
#import "MasterCard.h"
#import "Samsung.h"


@implementation EuropeanFactory

- (nonnull id<BankCardProtocol>)produceBankCard
{
    NSLog(@"Создана карта МастерКард");
    return [MasterCard new];
}

- (nonnull id<PhoneProtocol>)producePhone
{
    NSLog(@"Создан телефон Samsung");
    return [Samsung new];
}

@end
