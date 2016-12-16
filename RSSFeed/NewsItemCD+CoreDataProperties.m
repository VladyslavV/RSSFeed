//
//  NewsItemCD+CoreDataProperties.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/16/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "NewsItemCD+CoreDataProperties.h"

@implementation NewsItemCD (CoreDataProperties)

+ (NSFetchRequest<NewsItemCD *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NewsItemCD"];
}

@dynamic title;
@dynamic newsDescription;
@dynamic newsLink;
@dynamic pubData;
@dynamic imageURL;

@end
