//
//  FeedView.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/7/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "FeedView.h"
#import "Masonry.h"
#import <objc/message.h>

@interface FeedView () <UITableViewDelegate, UITableViewDataSource, UITraitEnvironment, UISearchBarDelegate>

@property (nonatomic, strong) UITableView* tableView;
@property (strong, nonatomic) UISearchBar* searchBar;
@end

@implementation FeedView

-(UISearchBar*) searchBar {
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
        _searchBar.translatesAutoresizingMaskIntoConstraints = NO;
        _searchBar.delegate = self;
        self.tableView.tableHeaderView = _searchBar;
    }
    return _searchBar;
}

-(UIRefreshControl*) refrechControl {
    if (_refrechControl == nil) {
        _refrechControl = [UIRefreshControl new];
        [_refrechControl addTarget:self
                            action:@selector(updateModel)
                  forControlEvents:UIControlEventValueChanged];
    }
    return _refrechControl;
}

-(void) updateModel {
    self.searchBar.text = @"";
    [self.feedViewModel updateModel];
}

-(UITableView*) tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 300.0;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        
        [self addSubview:_tableView];
        [_tableView addSubview:self.refrechControl];
        [self addSubview:self.searchBar];
    }
    return _tableView;
}

-(void) updateView {
    [self.tableView reloadData];
    self.searchBar.placeholder = [self.feedViewModel searchBarPlaceholder];
    [self.refrechControl endRefreshing];
}

#pragma mark - Trait Collection Delegate Methods

-(void) traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.equalTo(self);
        make.top.equalTo(self.mas_top).with.offset(0);
    }];
    
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.superview);
    }];
}

#pragma mark - Search Bar Delegate Methods

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [searchBar setShowsCancelButton:YES animated:YES];
    [self.feedViewModel filterTableWithString:searchBar.text withCompletion:^{
        [self.tableView reloadData];
    }];
}

-(void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
}

-(void) searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    [self.searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [self updateModel];
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

#pragma mark - TableView Delegate Methods

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchBar resignFirstResponder];
    [self.delegate cellAtRowWasSelected:indexPath.row];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.feedViewModel tableView:self.tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.feedViewModel tableView:self.tableView cellForRowAtIndexPath:indexPath];
}


@end
