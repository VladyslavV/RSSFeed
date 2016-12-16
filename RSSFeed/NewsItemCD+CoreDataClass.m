//
//  NewsItemCD+CoreDataClass.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/16/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "NewsItemCD+CoreDataClass.h"
#import "AppDelegate.h"

@implementation NewsItemCD


+ (NSArray * _Nonnull)getObjectsArrayWithPredicate:(NSPredicate * _Nullable)thePredicate
                              propertyToFetchArray:(NSArray<NSString *> * _Nullable)thePropertyToFetchArray
                               sortDescriptorArray:(NSArray<NSSortDescriptor *> * _Nullable)theSortDescriptorArray {
    
    NSFetchRequest *theFetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([self class])];
    
    if (thePredicate) {
        theFetchRequest.predicate = thePredicate;
    }
    theFetchRequest.includesSubentities = NO;
    if (thePropertyToFetchArray.count) {
        
        theFetchRequest.propertiesToFetch = thePropertyToFetchArray;
    }
    if (theSortDescriptorArray.count) {
        
        theFetchRequest.sortDescriptors = theSortDescriptorArray;
    }
    NSManagedObjectContext *theMOC = [((AppDelegate *)[UIApplication sharedApplication].delegate) getContext];
    return [theMOC executeFetchRequest:theFetchRequest error:nil];
}

#pragma mark - Clean

+ (void) cleanAll {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName: NSStringFromClass([self class])];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    
    NSError *deleteError = nil;
    NSPersistentStoreCoordinator *storeCoordinator = [((AppDelegate *)[UIApplication sharedApplication].delegate) getStoreCoordinator];
    NSManagedObjectContext *theMOC = [((AppDelegate *)[UIApplication sharedApplication].delegate) getContext];
    
    [storeCoordinator executeRequest:delete withContext:theMOC error:&deleteError];
    
    [theMOC save:nil];
}

#pragma mark - Create Object With Dictionary

+ (instancetype _Nonnull) publicInitWithDictionary:(NSDictionary * _Nonnull)theDictionary
{
    return [[[self class] alloc] initWithDictionary:theDictionary];
}

- (instancetype _Nonnull)initWithDictionary:(NSDictionary * _Nonnull)theDictionary
{
    NSManagedObjectContext *theMOC = [((AppDelegate *)[UIApplication sharedApplication].delegate) getContext];
    self = [self initWithEntity:[NSEntityDescription entityForName:NSStringFromClass([self class])
                                            inManagedObjectContext:theMOC]
 insertIntoManagedObjectContext:theMOC];
    if (self) {
        [self methodFillWithDictionary:theDictionary];
    }
    return self;
}

- (void)methodFillWithDictionary:(NSDictionary * _Nonnull)theDictionary{
    
    id theValue;
    
    theValue = theDictionary[@"imageURL"];
    self.imageURL = theValue && theValue != [NSNull null] ? [NSString stringWithFormat:@"%@", theValue] : nil;
    
    theValue = theDictionary[@"title"];
    self.title = theValue && theValue != [NSNull null] ? [NSString stringWithFormat:@"%@", theValue] : nil;
    
    theValue = theDictionary[@"newsDescription"];
    self.newsDescription = theValue && theValue != [NSNull null] ? [NSString stringWithFormat:@"%@", theValue] : nil;
    
    theValue = theDictionary[@"newsLink"];
    self.newsLink = theValue && theValue != [NSNull null] ? [NSString stringWithFormat:@"%@", theValue] : nil;
    
    theValue = theDictionary[@"pubDate"];
    self.pubDate = theValue;
}
@end
