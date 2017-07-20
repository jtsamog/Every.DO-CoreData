//
//  AppDelegate.h
//  Every.DO-CoreData
//
//  Created by Endeavour2 on 7/19/17.
//  Copyright © 2017 SamOg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (nonatomic, readonly) NSManagedObjectContext *context;


- (void)saveContext;


@end

