//
//  SplitMasterViewController.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/19/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "SplitMasterTVC.h"
#import "FeedViewController.h"

@interface SplitMasterTVC ()

@end

@implementation SplitMasterTVC

NSArray* controllersArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.splitViewController.delegate = self;
    self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;

    
    
    NSString*feedViewControllerString = NSStringFromClass([FeedViewController class]);
    controllersArray = @[feedViewControllerString];
    
    self.view.backgroundColor = [UIColor redColor];

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
    
    NSLog(@"%@", controllersArray[indexPath.row]);
    
    [self createControllerWithTitle:controllersArray[indexPath.row]];
}

-(void) createControllerWithTitle:(NSString*) title {
    NSString* vc = NSStringFromClass([FeedViewController class]);
   
    if ([title isEqualToString:vc]) {
        
        
        
        FeedViewController* cc = [FeedViewController new];
        UINavigationController *detailNav = [[UINavigationController alloc] initWithRootViewController:cc];
        detailNav.navigationItem.leftBarButtonItem = [self.splitViewController displayModeButtonItem];
        
        [self.splitViewController showDetailViewController:detailNav sender:self];
       // [self presentViewController:detailNav animated:YES completion:nil];
        
    }
    
}


#pragma mark - Split View Controller Delegate

-(BOOL) splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    return YES;
}

@end
