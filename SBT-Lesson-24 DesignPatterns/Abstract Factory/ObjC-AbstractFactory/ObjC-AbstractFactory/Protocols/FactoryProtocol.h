//
//  FactoryProtocol.h
//  ObjC-AbstractFactory
//
//  Created by Dmitry Shapkin on 21/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "BankCardProtocol.h"
#import "PhoneProtocol.h"

@import Foundation;


NS_ASSUME_NONNULL_BEGIN

@protocol FactoryProtocol <NSObject>

- (id<BankCardProtocol>)produceBankCard;
- (id<PhoneProtocol>)producePhone;

@end

NS_ASSUME_NONNULL_END
