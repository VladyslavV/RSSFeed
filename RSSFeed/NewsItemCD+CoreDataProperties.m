//
//  NewsItemCD+CoreDataProperties.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/16/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "NewsItemCD+CoreDataProperties.h"

@implementation NewsItemCD (CoreDataProperties)

+ (NSFetchRequest<NewsItemCD *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NewsItemCD"];
}

@dynamic title;
@dynamic newsDescription;
@dynamic newsLink;
@dynamic pubDate;
@dynamic imageURL;

@end
