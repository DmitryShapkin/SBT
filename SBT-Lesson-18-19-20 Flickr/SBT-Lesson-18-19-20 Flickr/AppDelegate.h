//
//  AppDelegate.h
//  SBT-Lesson-18-19-20 Flickr
//
//  Created by Dmitry Shapkin on 18/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


@import UIKit;
@import CoreData;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

@end

