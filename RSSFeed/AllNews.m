//
//  AllNews.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/6/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "AllNews.h"

@implementation AllNews

@synthesize data = _data;

-(NSMutableArray*) data {
    if (_data == nil) {
        _data = [NSMutableArray new];
    }
    return  _data;
}

-(void) addItem:(NSMutableDictionary*) newItemDict {
    NewsItem * newsItem = [[NewsItem alloc] initWithDict:newItemDict];
    [self.data addObject:newsItem];
}

@end
