//
//  AmericanFactory.m
//  ObjC-AbstractFactory
//
//  Created by Dmitry Shapkin on 23/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "AmericanFactory.h"
#import "Visa.h"
#import "IPhone.h"


@implementation AmericanFactory

- (nonnull id<BankCardProtocol>)produceBankCard
{
    NSLog(@"Создана карта Виза");
    return [Visa new];
}

- (nonnull id<PhoneProtocol>)producePhone
{
    NSLog(@"Создан телефон iPhone");
    return [IPhone new];
}

@end
