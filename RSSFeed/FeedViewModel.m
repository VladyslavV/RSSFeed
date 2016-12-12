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

#pragma mark - Fetcher Delegate

-(void) allNewsParsed:(AllNews *)allNews {
    self.allNews = allNews;
    [self.delegate modelWasUpdated];
}

#pragma mark - Table View


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allNews.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell* cell = [[CustomTableViewCell alloc] init];
    NewsItem* item = self.allNews.data[indexPath.row];
    cell.titleLabel.text = item.title;
    cell.descriptionLabel.text = item.newsDescription;
    return cell;
}

#pragma mark - Create Feed Detail View Model

-(FeedDetailViewModel*) createFeedDetailViewModelForCell:(NSInteger) cellIndex {
    NewsItem* item = self.allNews.data[cellIndex];
    FeedDetailViewModel* feedDetailViewModel = [[FeedDetailViewModel alloc] initWithItem:item];
    return feedDetailViewModel;
}




@end
