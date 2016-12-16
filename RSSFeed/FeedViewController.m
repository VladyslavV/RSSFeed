//
//  ViewController.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/6/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedViewDetailVC.h"


@interface FeedViewController ()
//UI
@property (strong, nonatomic) FeedView* feedView;

//ViewModel
@property (strong, nonatomic) FeedViewModel* feedViewModel;

@end

@implementation FeedViewController

#pragma mark - FeedView Delegate

-(void) cellAtRowWasSelected:(NSInteger)cell {
    FeedDetailViewModel* model = [self.feedViewModel createFeedDetailViewModelForCell:cell];
    FeedViewDetailVC* vc = [[FeedViewDetailVC alloc] initWithViewModel:model];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - FeedViewModel Delegate

-(void) modelWasUpdated {
    [self.feedView update];
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
        _feedViewModel = [FeedViewModel new];
        _feedViewModel.delegate = self;
    }
    return _feedViewModel;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.feedView];
    [self.feedViewModel updateModel];
    self.navigationItem.title = NSLocalizedString(@"navigationbar.main.title", nil);
}

@end
