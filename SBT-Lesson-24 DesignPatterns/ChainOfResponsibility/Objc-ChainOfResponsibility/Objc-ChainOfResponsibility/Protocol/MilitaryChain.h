//
//  MilitaryChain.h
//  Objc-ChainOfResponsibility
//
//  Created by Dmitry Shapkin on 23/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


@import Foundation;


NS_ASSUME_NONNULL_BEGIN

@protocol MilitaryChain <NSObject>

@property (nonatomic, assign) NSInteger strength;
@property (nonatomic, strong) id<MilitaryChain> nextRank;

- (void)shouldDefeatWithStrength:(NSInteger)amount;

@end

NS_ASSUME_NONNULL_END
