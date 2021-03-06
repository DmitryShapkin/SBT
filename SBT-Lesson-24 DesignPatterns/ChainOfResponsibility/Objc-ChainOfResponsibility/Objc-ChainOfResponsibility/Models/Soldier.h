//
//  Soldier.h
//  Objc-ChainOfResponsibility
//
//  Created by Dmitry Shapkin on 23/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "MilitaryChain.h"

@import Foundation;


NS_ASSUME_NONNULL_BEGIN

@interface Soldier : NSObject <MilitaryChain>

@property (nonatomic, assign) NSInteger strength;
@property (nonatomic, nullable, strong) id<MilitaryChain> nextRank;

@end

NS_ASSUME_NONNULL_END
