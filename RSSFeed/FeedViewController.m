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

#import "Masonry.h"

@interface FeedViewController ()

//UI
@property (strong, nonatomic) FeedView* feedView;

@property (strong, nonatomic) UIView* view1;


//ViewModel
@property (strong, nonatomic) FeedViewModel* feedViewModel;

@end

@implementation FeedViewController

{

    NSLayoutConstraint *_top;
    NSLayoutConstraint *_left;
    NSLayoutConstraint *_width;
    NSLayoutConstraint *_height;

}

#pragma mark - Init Variables

-(FeedView*) feedView {
    if (_feedView == nil) {
        _feedView = [FeedView new];
        _feedView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _feedView;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [coordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {

        UIDeviceOrientation currentOrientaation = [[UIDevice currentDevice] orientation];
        switch (currentOrientaation) {
            case UIDeviceOrientationLandscapeLeft:
            case UIDeviceOrientationLandscapeRight:
                [self.feedView setUpView];
                break;
            default:
                [self.feedView setUpView];
                break;
        }
    }];
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
    [self.feedView setUpView];
    [self.feedView setBackgroundColor:[UIColor redColor]];
}





@end
