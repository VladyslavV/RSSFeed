//
//  NewsItem.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/6/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "NewsItem.h"

@interface NewsItem()

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
        self.imageURL = nodeDict[@"imageURL"];
        self.newsDescription = nodeDict[@"newsDescription"];
        self.pubDate = nodeDict[@"pubData"];
        self.newsLink = nodeDict[@"newsLink"];
        self.title = nodeDict[@"title"];
    }
    return self;
}

@end
