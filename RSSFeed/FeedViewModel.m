//
//  FeedViewModel.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/8/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "FeedViewModel.h"
#import "Fetcher.h"

@interface FeedViewModel() <FetcherDelegate>

@property (strong, nonatomic) Fetcher* fetcher;
@property (strong, nonatomic) AllNews* allNews;

@end

@implementation FeedViewModel

-(Fetcher*) fetcher {
    if (_fetcher == nil) {
        _fetcher = [Fetcher new];
        _fetcher.delegate = self;
    }
    return _fetcher;
}

#pragma mark - Fetcher Delegate

-(void) allNewsParsed:(AllNews *)allNews {
    self.allNews = allNews;
    NewsItem* item = allNews.data[3];
    NSLog(@"%@", item.title);
}

-(void) updateModel {
    [self.fetcher fetchData];
}


@end
