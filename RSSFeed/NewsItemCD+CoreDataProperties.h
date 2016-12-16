//
//  NewsItemCD+CoreDataProperties.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/16/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "NewsItemCD+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface NewsItemCD (CoreDataProperties)

+ (NSFetchRequest<NewsItemCD *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *newsDescription;
@property (nullable, nonatomic, copy) NSString *newsLink;
@property (nullable, nonatomic, copy) NSString *pubDate;
@property (nullable, nonatomic, copy) NSString *imageURL;

@end

NS_ASSUME_NONNULL_END
