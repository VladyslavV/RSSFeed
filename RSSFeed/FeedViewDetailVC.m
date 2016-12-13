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
#import "FeedViewDetailMainView.h"

@interface FeedViewDetailVC ()

@property (strong, nonatomic) FeedDetailViewModel* feedDetailViewModel;

@property (strong, nonatomic) FeedViewDetailMainView* mainView;

@end

@implementation FeedViewDetailVC

-(FeedViewDetailMainView*) mainView {
    if (_mainView == nil) {
        _mainView = [[FeedViewDetailMainView new] initWithFrame:CGRectZero];
        _mainView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _mainView;
}


- (instancetype)initWithViewModel:(FeedDetailViewModel*) feedDetailViewModel
{
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
    
    // nav button
    self.mainView.barButtonOpenInSafari.target = self;
    self.mainView.barButtonOpenInSafari.action = @selector(openInSafari);
    self.navigationItem.rightBarButtonItem = self.mainView.barButtonOpenInSafari;

    self.mainView.titleLabel.attributedText = [self.mainView getAttributedString:[self.feedDetailViewModel titleText]];
    self.mainView.newsDescriptionLabel.text = [self.feedDetailViewModel newsDescriptionText];
    self.mainView.pubDateLabel.text = [self.feedDetailViewModel pubDateText];
    [self.feedDetailViewModel fetchImageWithUrl:self.feedDetailViewModel.imageURL andCallBack:^(NSData *imageData) {
        UIImage* image = [UIImage imageWithData:imageData];
        self.mainView.newsImageView.image = image;
    }];
    
    [self.view setNeedsUpdateConstraints];
}

#pragma mark - Button Actions

-(void) openInSafari {
    [[UIApplication sharedApplication] openURL:[self.feedDetailViewModel newsLink]
                                       options:@{}
                             completionHandler:nil];
}

#pragma mark - UIContentContainer protocol methods

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.mainView toggleConstraintsForTraitCollection:newCollection];
}

@end
