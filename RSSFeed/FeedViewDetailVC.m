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

@interface FeedViewDetailVC ()

@property (strong, nonatomic) FeedDetailViewModel* feedDetailViewModel;
@property (strong, nonatomic) FeedViewDetailMainView* mainView;

@property (strong, nonatomic) ImageViewerVC* imageViewerVC;

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
    self.navigationController.navigationBar.topItem.title = NSLocalizedString(@"back.bar.button", nil); // back button
    self.navigationItem.rightBarButtonItem = self.mainView.barButtonOpenInSafari;
    
    [self.view setNeedsUpdateConstraints];
}

#pragma mark - UIContentContainer protocol methods

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.mainView removeBlurView];
    [self.imageViewerVC dismissViewControllerAnimated:NO completion:nil];
    [self.mainView toggleConstraintsForTraitCollection:newCollection];
}

#pragma mark - Image Tapped Delegate

-(void) imageTapped {
    self.imageViewerVC = [[ImageViewerVC alloc] initWithImage:self.mainView.newsImageView.image];
    self.imageViewerVC.modalPresentationStyle = UIModalPresentationPopover;
    
    if ([self.traitCollection mk_matchesPhonePortrait]) {
        self.imageViewerVC.preferredContentSize = CGSizeMake(self.view.frame.size.width * 0.8, self.view.frame.size.height * 0.5);
    } else if ([self.traitCollection mk_matchesPhoneLandscape]) {
        self.imageViewerVC.preferredContentSize = CGSizeMake(self.view.frame.size.height * 0.8, self.view.frame.size.width * 0.5);
    }
    
    [self.mainView addBlurView];
    //retrieve popvc pointer
    UIPopoverPresentationController* popVC =  self.imageViewerVC.popoverPresentationController;
    
    if (popVC != nil) {
        popVC.delegate = self;
        popVC.sourceView = self.view;
        popVC.sourceRect = self.view.frame;
        
        popVC.canOverlapSourceViewRect = NO;
        popVC.permittedArrowDirections = 0;
    }
    
    [self presentViewController: self.imageViewerVC animated:YES completion:nil];
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection {
    return UIModalPresentationNone; 
}

- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    [self.mainView removeBlurView];
    return YES;
}


@end
