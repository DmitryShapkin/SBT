//
//  ViewController.m
//  Objc-ChainOfResponsibility
//
//  Created by Dmitry Shapkin on 23/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "ViewController.h"
#import "Enemy.h"
#import "Soldier.h"
#import "Officer.h"
#import "General.h"


@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /** Сборка цепочки ответственности */
    
    Enemy *enemy = [Enemy new];
    Soldier *soldier = [Soldier new];
    Officer *officer = [Officer new];
    General *general = [General new];
    
    soldier.nextRank = officer;
    officer.nextRank = general;
    
    [soldier shouldDefeatWithStrength:enemy.strength];
}

@end
