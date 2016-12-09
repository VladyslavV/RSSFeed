//
//  ViewController.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/6/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedView.h"
#import "FeedViewModel.h"


@interface FeedViewController ()

//UI
@property (strong, nonatomic) FeedView* feedView;

//ViewModel
@property (strong, nonatomic) FeedViewModel* feedViewModel;

@end

@implementation FeedViewController


#pragma mark - Init Variables

-(FeedView*) feedView {
    if (_feedView == nil) {
        _feedView = [FeedView new];
        _feedView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _feedView;
}

-(FeedViewModel*) feedViewModel {
    if (_feedViewModel == nil) {
        _feedViewModel = [FeedViewModel new];
        _feedViewModel.feedView = _feedView;
    }
    return _feedViewModel;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.feedView];
}





@end
