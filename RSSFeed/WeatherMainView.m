//
//  WeatherMainView.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/19/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "WeatherMainView.h"
#import "Masonry.h"
#import "WeatherCell.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface WeatherMainView() <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView* tableView;


@end

@implementation WeatherMainView


-(void)setViewModel:(WeatherViewModel *)viewModel {
    _viewModel = viewModel;
    [self.tableView reloadData];
}

-(UITableView*) tableView {
    if (!_tableView) {
        _tableView = [[[NSBundle mainBundle] loadNibNamed:@"WeatherTVC" owner:self options:nil] objectAtIndex:0];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 200;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.scrollEnabled = YES;
        _tableView.userInteractionEnabled = YES;
        
    }
    return _tableView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.tableView];
        UINib *nib = [UINib nibWithNibName:@"WeatherCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:@"WeatherCell"];
        
    }
    return self;
}

-(void) layoutSubviews {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setMinimumSize:self.frame.size];
    [SVProgressHUD show];
    
    
    self.tableView.frame = self.bounds;
}

-(void) updateView {
    [SVProgressHUD dismiss];
    [self.tableView reloadData];
}

-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    self.frame = self.superview.frame;
    self.tableView.frame = self.frame;
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel tableView:self.tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel tableView:self.tableView cellForRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel tableView:self.tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

@end
