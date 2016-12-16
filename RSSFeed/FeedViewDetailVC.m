//
//  FeedViewDetailVC.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/9/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "FeedViewDetailVC.h"
#import "Masonry.h"
#import "UITraitCollection+MKAdditions.h"
#import "ImageViewerVC.h"
#import "ImageViewerViewModel.h"

@interface FeedViewDetailVC ()

@property (strong, nonatomic) FeedDetailViewModel* feedDetailViewModel;
@property (strong, nonatomic) FeedViewDetailMainView* mainView;


@end

@implementation FeedViewDetailVC

-(FeedViewDetailMainView*) mainView {
    if (_mainView == nil) {
        _mainView = [[FeedViewDetailMainView new] initWithModel:self.feedDetailViewModel];
        _mainView.delegate = self;
        _mainView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _mainView;
}

- (instancetype)initWithViewModel:(FeedDetailViewModel*) feedDetailViewModel {
    self = [super init];
    if (self) {
        _feedDetailViewModel = feedDetailViewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainView];
    
    [self.mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    
    // nav buttons
    self.navigationItem.rightBarButtonItem = self.mainView.barButtonOpenInSafari;
    
    [self.view setNeedsUpdateConstraints];
}

#pragma mark - UIContentContainer protocol methods

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.mainView toggleConstraintsForTraitCollection:newCollection];
}

#pragma mark - Image Tapped Delegate

-(void) imageTapped {
    ImageViewerViewModel* imageViewerViewModel = [[ImageViewerViewModel alloc] initWithImage:self.mainView.newsImageView.image];
    
    ImageViewerVC* vc = [[ImageViewerVC alloc] initWithViewModel:imageViewerViewModel];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - Share to media

-(void) shareToMedia:(NSURL *)newsLink {
    NSArray* itemsToShare = @[newsLink];
    UIActivityViewController * activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
    
    activityVC.excludedActivityTypes = @[UIActivityTypeMail,
                                         UIActivityTypeAirDrop,
                                         UIActivityTypeMessage,
                                         UIActivityTypePostToVimeo,
                                         UIActivityTypeOpenInIBooks,
                                         ];
    [self presentViewController:activityVC animated:YES completion:nil];
}


@end
