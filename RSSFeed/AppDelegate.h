//
//  AppDelegate.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/6/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(NSPersistentStoreCoordinator*) getStoreCoordinator;
-(NSManagedObjectContext*) getContext;

- (void)saveContext;

@end

