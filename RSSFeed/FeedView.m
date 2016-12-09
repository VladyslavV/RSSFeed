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

@interface FeedView () <UITableViewDelegate, UITableViewDataSource, UITraitEnvironment>

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

#pragma mark - Trait Collection Delegate Methods

-(void) traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.equalTo(self);
        make.top.equalTo(self.mas_top).with.offset(20);
    }];
    
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.superview);
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
