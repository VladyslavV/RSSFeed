//
//  ViewController.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/6/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "ViewController.h"
#import "Fetcher.h"
#import "AllNews.h"
#import "NewsItem.h"


@interface ViewController () <FetcherDelegate>

@property (strong, nonatomic) AllNews* allNews;
@property (strong, nonatomic) Fetcher* fetcher;

@end

@implementation ViewController

#pragma mark - Init Variables

-(Fetcher*) fetcher {
    if (_fetcher == nil) {
        _fetcher = [Fetcher new];
        _fetcher.delegate = self;
    }
    return _fetcher;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.fetcher fetchData];
    
}

#pragma mark - Fetcher Delegate

-(void) allNewsParsed:(AllNews *)allNews {
    self.allNews = allNews;
    NewsItem* item = self.allNews.data[2];
    NSLog(@"%@", item.title);
    NSLog(@"%@", item.newsDescription);
    
    if ([NSThread isMainThread]) {
        NSLog(@"yes");
    }
}

@end
