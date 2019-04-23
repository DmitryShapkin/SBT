//
//  Visa.h
//  ObjC-AbstractFactory
//
//  Created by Dmitry Shapkin on 23/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "BankCardProtocol.h"

@import Foundation;


NS_ASSUME_NONNULL_BEGIN

@interface Visa : NSObject <BankCardProtocol>

@end

NS_ASSUME_NONNULL_END
