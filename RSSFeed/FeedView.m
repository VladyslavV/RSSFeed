//
//  FeedView.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/7/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "FeedView.h"
#import "CustomTableViewCell.h"
#import "Masonry.h"

@interface FeedView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;

@end

@implementation FeedView

-(UITableView*) tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:self.tableView];
    }
    return _tableView;
}

-(void) setUpView {
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.superview).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.superview).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - TableView Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell* cell = [[CustomTableViewCell alloc] init];
    
    
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}


@end
