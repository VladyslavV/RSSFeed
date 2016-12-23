//
//  SplitMasterViewController.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/19/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "SplitMasterTVC.h"
#import "FeedViewController.h"
#import "WeatherVC.h"

@interface SplitMasterTVC () 

@end

@implementation SplitMasterTVC

NSArray* controllersArray;

NSString* rssController = @"BBC feed";
NSString* weatherController = @"Weather Info";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.splitViewController.delegate = self;
    self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    controllersArray = @[rssController, weatherController];
}

#pragma mark - Table View Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return controllersArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    cell.textLabel.text = controllersArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self createControllerWithTitle:controllersArray[indexPath.row]];
}

-(void) createControllerWithTitle:(NSString*) title {

    if ([title isEqualToString:rssController]) {
        FeedViewController* feedViewController = [FeedViewController new];
        if (self.splitViewController.isCollapsed) {
            [self.splitViewController showDetailViewController:feedViewController sender:self];
        }
        else {
            UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:feedViewController];
            [self.splitViewController showDetailViewController:nav sender:self];
        }
    }
    else if ([title isEqualToString:weatherController]) {
        WeatherVC* weatherVC = [WeatherVC new];
        if (self.splitViewController.isCollapsed) {
            [self.splitViewController showDetailViewController:weatherVC sender:self];
        }
        else {
            UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:weatherVC];
            [self.splitViewController showDetailViewController:nav sender:self];
        }
    }
}

#pragma mark - Split View Controller Delegate

-(BOOL) splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    return YES;
}






@end
