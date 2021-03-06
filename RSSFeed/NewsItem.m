//
//  NewsItem.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/6/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "NewsItem.h"

@interface NewsItem()

@property (strong, nonatomic, readwrite) NSMutableDictionary * dict;

@property (nonatomic, strong, readwrite) NSString* title;
@property (nonatomic, strong, readwrite) NSString* newsDescription;
@property (nonatomic, strong, readwrite) NSString* newsLink;
@property (nonatomic, strong, readwrite) NSString* pubDate;
@property (nonatomic, strong, readwrite) NSString* imageURL;

@end

@implementation NewsItem

- (instancetype)initWithDict:(NSMutableDictionary*) nodeDict;
{
    self = [super init];
    if (self) {
        _dict = nodeDict;
        self.imageURL = nodeDict[@"imageURL"];
        self.newsDescription = nodeDict[@"newsDescription"];
        self.pubDate = nodeDict[@"pubDate"];
        self.newsLink = nodeDict[@"newsLink"];
        self.title = nodeDict[@"title"];
    }
    return self;
}

- (NSMutableDictionary*) getDict {
    return self.dict;
}

@end
