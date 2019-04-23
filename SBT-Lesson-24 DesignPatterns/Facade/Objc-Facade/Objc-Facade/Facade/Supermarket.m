//
//  Supermarket.m
//  Objc-Facade
//
//  Created by Dmitry Shapkin on 23/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "Supermarket.h"
#import "FruitShop.h"
#import "MeatShop.h"
#import "MilkShop.h"
#import "SweetShop.h"
#import "BreadShop.h"


@implementation Supermarket

- (NSString *)buyProducts
{
    FruitShop *fruitShop = [FruitShop new];
    MeatShop *meatShop = [MeatShop new];
    MilkShop *milkShop = [MilkShop new];
    SweetShop *sweetShop = [SweetShop new];
    BreadShop *breadShop = [BreadShop new];
    
    NSMutableString *products = [NSMutableString string];
    [products appendString:[NSString stringWithFormat:@"%@, ", [fruitShop buyFruits]]];
    [products appendString:[NSString stringWithFormat:@"%@, ", [meatShop buyMeat]]];
    [products appendString:[NSString stringWithFormat:@"%@, ", [milkShop buyMilk]]];
    [products appendString:[NSString stringWithFormat:@"%@, ", [sweetShop buySweet]]];
    [products appendString:[NSString stringWithFormat:@"%@.", [breadShop buyBread]]];

    return [NSString stringWithFormat: @"Я купил: %@", products];
}

@end
