//
//  NewsItem.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/6/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject

- (instancetype)initWithDict:(NSMutableDictionary*) nodeDict;


@property (nonatomic, strong, readonly) NSString* title;
@property (nonatomic, strong, readonly) NSString* newsDescription;
@property (nonatomic, strong, readonly) NSString* newsLink;
@property (nonatomic, strong, readonly) NSString* pubDate;
@property (nonatomic, strong, readonly) NSString* imageURL;

@end
