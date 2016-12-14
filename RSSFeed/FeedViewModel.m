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

@interface FeedViewModel() <FetcherDelegate>

@property (strong, nonatomic) Fetcher* fetcher;
@property (strong, nonatomic) AllNews* allNews;
@property (strong, nonatomic) NSArray* filteredNews;

@end

@implementation FeedViewModel

-(Fetcher*) fetcher {
    if (_fetcher == nil) {
        _fetcher = [Fetcher new];
        _fetcher.delegate = self;
    }
    return _fetcher;
}

-(void) updateModel {
    [self.fetcher fetchData];
}

-(NSString*) searchBarPlaceholder {
    return [NSString localizedStringWithFormat:NSLocalizedString(@"%d.item(s)", nil), self.filteredNews.count];
}

#pragma mark - Fetcher Delegate

-(void) allNewsParsed:(AllNews *)allNews {
    self.allNews = allNews;
    self.filteredNews = self.allNews.data;
    [self.delegate modelWasUpdated];
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
    cell.numberLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    return cell;
}

#pragma mark - Create Feed Detail View Model

-(FeedDetailViewModel*) createFeedDetailViewModelForCell:(NSInteger) cellIndex {
    NewsItem* item = self.allNews.data[cellIndex];
    FeedDetailViewModel* feedDetailViewModel = [[FeedDetailViewModel alloc] initWithItem:item];
    return feedDetailViewModel;
}

#pragma mark - Filter Table View

-(void) filterTableWithString:(NSString*) searchString withCompletion:(void (^)(void)) completed {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K beginswith[c] %@", NSStringFromSelector(@selector(title)), searchString];
        self.filteredNews = [self.allNews.data filteredArrayUsingPredicate:predicate];
        if (self.filteredNews.count < 1) {
            self.filteredNews = self.allNews.data;
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            completed();
        });
    });
}

@end
