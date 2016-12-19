//
//  ViewController.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/6/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedViewDetailVC.h"
#import "Reachability.h"

@interface FeedViewController ()
//UI
@property (strong, nonatomic) FeedView* feedView;

//ViewModel
@property (strong, nonatomic) FeedViewModel* feedViewModel;


@end

@implementation FeedViewController

#pragma mark - FeedView Delegate

-(void)userInOnlineMode:(BOOL) onlineMode {
    if (onlineMode) {
        [self.feedViewModel loadModelFromWeb];
    }
    else {
        [self.feedViewModel loadModelFromCoreData];
    }
}

-(void) cellAtRowWasSelected:(NSInteger)cell {
    FeedDetailViewModel* model = [self.feedViewModel createFeedDetailViewModelForCell:cell];
    FeedViewDetailVC* vc = [[FeedViewDetailVC alloc] initWithViewModel:model];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - FeedViewModel Delegate

-(void) modelWasUpdated {
    [self.feedView updateView];
}

-(void) modelFailedToUpdate {
    [self.feedView updateView];
}

#pragma mark - Init Variables

-(FeedView*) feedView {
    if (_feedView == nil) {
        _feedView = [FeedView new];
        _feedView.translatesAutoresizingMaskIntoConstraints = NO;
        _feedView.feedViewModel = self.feedViewModel;
        _feedView.delegate = self;
    }
    return _feedView;
}

-(FeedViewModel*) feedViewModel {
    if (_feedViewModel == nil) {
        
#warning - Core Data
        _feedViewModel = [FeedViewModel new];
        _feedViewModel.delegate = self;
    }
    return _feedViewModel;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.feedView];
    [self.feedViewModel loadModelFromWeb];
    self.navigationItem.title = NSLocalizedString(@"navigationbar.main.title", nil);
    
    [self internet];
}

-(void) internet {
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    reach.reachableBlock = ^(Reachability*reach)
    {
        // keep in mind this is called on a background thread
        // and if you are updating the UI it needs to happen
        // on the main thread, like this:
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"REACHABLE!");
        });
    };
    
    reach.unreachableBlock = ^(Reachability*reach)
    {
        NSLog(@"UNREACHABLE!");
    };
    
    [reach startNotifier];
}



-(void) viewDidAppear:(BOOL)animated {
    [self.feedView updateView];
}

@end
