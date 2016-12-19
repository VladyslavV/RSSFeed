//
//  FeedView.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/7/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "FeedView.h"
#import "Masonry.h"

typedef enum : NSUInteger {
    SegmentedControlValuesOnline,
    SegmentedControlValuesDevice
} SegmentedControlValues;

@interface FeedView () <UITableViewDelegate, UITableViewDataSource, UITraitEnvironment, UISearchBarDelegate>

@property (strong, nonatomic) UIView* tableHeaderView;
@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) UISearchBar* searchBar;
@property (strong, nonatomic) UISegmentedControl* segmentedControl;

@end

@implementation FeedView


// header that holds segment control and search bar
-(UIView*) tableHeaderView {
    if (_tableHeaderView == nil) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableHeaderView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableHeaderView.backgroundColor = [UIColor whiteColor];
        [_tableHeaderView addSubview:self.segmentedControl];
        [_tableHeaderView addSubview:self.searchBar];
    }
    return _tableHeaderView;
}

-(UISegmentedControl*) segmentedControl {
    if (_segmentedControl == nil) {
        _segmentedControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"Online",@"Device",nil]];
        _segmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
        [_segmentedControl setSelectedSegmentIndex:0];
        [_segmentedControl addTarget:self
                              action:@selector(segmentControlChanged:)
                    forControlEvents:UIControlEventValueChanged];
       // [_segmentedControl setTintColor:[UIColor blueColor]];
    }
    return _segmentedControl;
}

-(UISearchBar*) searchBar {
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
        _searchBar.translatesAutoresizingMaskIntoConstraints = NO;
        _searchBar.delegate = self;
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
    
    if (self.segmentedControl.selectedSegmentIndex == SegmentedControlValuesOnline) {
        [self.delegate userInOnlineMode:YES];
        NSLog(@"online");
    }
    else if (self.segmentedControl.selectedSegmentIndex  == SegmentedControlValuesDevice) {
        [self.delegate userInOnlineMode:NO];
        NSLog(@"device");
    }
}

-(UITableView*) tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 300.0;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        
        [self addSubview:_tableView];
        [_tableView addSubview:self.tableHeaderView];
        _tableView.tableHeaderView = self.tableHeaderView;
        [_tableView addSubview:self.refrechControl];
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
    
    [self.tableHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.mas_top).with.offset(2);
        make.leading.trailing.equalTo(self);
    }];
    
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableHeaderView.mas_top);
        make.leading.trailing.equalTo(self.tableHeaderView);
    }];
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentedControl.mas_bottom).with.offset(2);
        make.bottom.equalTo(self.tableHeaderView.mas_bottom).with.offset(-2);
        make.leading.trailing.equalTo(self.tableHeaderView);
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.equalTo(self);
        make.top.equalTo(self.mas_top);
    }];
    
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.superview);
        make.trailing.leading.bottom.equalTo(self.superview);
    }];
    
}

#pragma mark - Segment Control

-(void) segmentControlChanged:(UISegmentedControl*) sender {
    self.searchBar.text = @"";

    if (sender.selectedSegmentIndex == SegmentedControlValuesOnline) {
        [self.delegate userInOnlineMode:YES];
        NSLog(@"online");
    }
    else if (sender.selectedSegmentIndex == SegmentedControlValuesDevice) {
        [self.delegate userInOnlineMode:NO];
        NSLog(@"device");
    }
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
