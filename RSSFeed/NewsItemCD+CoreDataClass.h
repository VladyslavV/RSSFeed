//
//  NewsItemCD+CoreDataClass.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/16/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsItemCD : NSManagedObject

+ (instancetype _Nonnull) publicInitWithDictionary:(NSDictionary * _Nonnull)theDictionary;

+ (NSArray * _Nonnull) getObjectsArrayWithPredicate:(NSPredicate * _Nullable)thePredicate
                              propertyToFetchArray:(NSArray<NSString *> * _Nullable)thePropertyToFetchArray
                               sortDescriptorArray:(NSArray<NSSortDescriptor *> * _Nullable)theSortDescriptorArray;


+ (void) cleanAll;


@end

NS_ASSUME_NONNULL_END

#import "NewsItemCD+CoreDataProperties.h"
