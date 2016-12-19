//
//  FeedViewModel.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/8/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "FeedViewModel.h"
#import "Fetcher.h"
#import "CustomTableViewCell.h"
#import "NewsItemCD+CoreDataClass.h"
#import "AppDelegate.h"
#import "Reachability.h"


@interface FeedViewModel() <FetcherDelegate>

@property (strong, nonatomic) Fetcher* fetcher;
@property (strong, nonatomic) AllNews* allNews;
@property (strong, nonatomic) NSArray* filteredNews;


@end

@implementation FeedViewModel

BOOL loadFromCoreData;

static NSString* dataURl = @"http://feeds.bbci.co.uk/news/rss.xml?edition=int";


-(Fetcher*) fetcher {
    if (_fetcher == nil) {
        _fetcher = [Fetcher new];
        _fetcher.delegate = self;
    }
    return _fetcher;
}


#pragma mark - Chose where to load data from

-(void) loadModelFromWeb {

    self.allNews = nil;
    self.filteredNews = nil;
    [self.fetcher fetchDataWithStringURL:dataURl];

}


-(NSString*) searchBarPlaceholder {
    return [NSString localizedStringWithFormat:NSLocalizedString(@"%d.item(s)", nil), self.filteredNews ? self.filteredNews.count : 0];
}

#pragma mark - Fetcher Delegate

-(void) allNewsParsed:(AllNews *)allNews {
    self.allNews = allNews;
    self.filteredNews = self.allNews.data;
    [self.delegate modelWasUpdated];
    [self writeToCoreData];
}

-(void)failFetching {
    self.allNews = nil;
    self.filteredNews = nil;
    [self.delegate modelWasUpdated];
}

#pragma mark - Core Data

-(void) writeToCoreData {
    [self cleanCoreData];
    // pass all news dictionaries to fill core data
    NSLog(@"%lu", (unsigned long)self.allNews.data.count);
    for (int i = 0; i < self.allNews.data.count; i++) {
        NewsItem* newsItem = self.allNews.data[i];
        NSDictionary* dict = newsItem.dict;
        NewsItemCD* item = [NewsItemCD publicInitWithDictionary:dict];
        item.index = [NSString stringWithFormat:@"%d", i];
    }
    NSManagedObjectContext* MOC = [(AppDelegate*)[UIApplication sharedApplication].delegate getContext];
    [MOC save:nil];
}

-(void) loadModelFromCoreData {
    NSSortDescriptor* sortByIndex = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:YES selector:@selector(localizedStandardCompare:)];
    NSArray* coreData = [NewsItemCD getObjectsArrayWithPredicate:nil propertyToFetchArray:nil sortDescriptorArray:@[sortByIndex]];
    NSLog(@"%lu", (unsigned long)coreData.count);
    self.allNews = [[AllNews alloc] init];
    self.allNews.data = [coreData mutableCopy];
    self.filteredNews = self.allNews.data;
    [self.delegate modelWasUpdated];
}

-(void) cleanCoreData {
    [NewsItemCD cleanAll];
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredNews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell* cell = [[CustomTableViewCell alloc] init];
    NewsItem* item = self.filteredNews[indexPath.row];
    cell.titleLabel.text = item.title;
    cell.descriptionLabel.text = item.newsDescription;
    cell.numberLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row + 1];
    return cell;
}

#pragma mark - Create Feed Detail View Model

-(FeedDetailViewModel*) createFeedDetailViewModelForCell:(NSInteger) cellIndex {
    NewsItem* item = self.filteredNews[cellIndex];
    FeedDetailViewModel* feedDetailViewModel = [[FeedDetailViewModel alloc] initWithItem:item];
    return feedDetailViewModel;
}

#pragma mark - Filter Table View

-(void) filterTableWithString:(NSString*) searchString withCompletion:(void (^)(void)) completed {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K beginswith[c] %@", NSStringFromSelector(@selector(title)), searchString];
        self.filteredNews = [self.allNews.data filteredArrayUsingPredicate:predicate];
        if (self.filteredNews.count < 1 && [searchString length] < 1) {
            self.filteredNews = self.allNews.data;
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            completed();
        });
    });
}

@end
