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

@interface FeedViewDetailVC ()

@property (strong, nonatomic) FeedDetailViewModel* feedDetailViewModel;

@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UILabel* newsDescriptionLabel;
@property (strong, nonatomic) UILabel* pubDateLabel;
@property (strong, nonatomic) UIImageView* newsImageView;

@property BOOL didSetConstraints;
@property NSArray *phonePortraitConstraints;
@property NSArray *phoneLandscapeConstraints;

@end

@implementation FeedViewDetailVC

-(UIImageView*) newsImageView {
    if (_newsImageView == nil) {
        _newsImageView = [UIImageView new];
        _newsImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _newsImageView;
}

-(UILabel*) pubDateLabel {
    if (_pubDateLabel == nil) {
        _pubDateLabel = [UILabel new];
        _pubDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _pubDateLabel.numberOfLines = 0;
        [_pubDateLabel setFont:[UIFont systemFontOfSize:8]];
    }
    return _pubDateLabel;
}

-(UILabel*) titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.numberOfLines = 0;
        [_titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_titleLabel sizeToFit];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UILabel*) newsDescriptionLabel {
    if (_newsDescriptionLabel == nil) {
        _newsDescriptionLabel = [UILabel new];
        _newsDescriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _newsDescriptionLabel.numberOfLines = 0;
        [_newsDescriptionLabel setFont:[UIFont systemFontOfSize:22]];
        [_newsDescriptionLabel sizeToFit];
        _newsDescriptionLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _newsDescriptionLabel;
}

- (instancetype)initWithViewModel:(FeedDetailViewModel*) feedDetailViewModel
{
    self = [super init];
    if (self) {
        self.didSetConstraints = NO;
        _feedDetailViewModel = feedDetailViewModel;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.newsImageView];
    [self.view addSubview:self.pubDateLabel];
    [self.view addSubview:self.newsDescriptionLabel];
    
    self.titleLabel.text = [self.feedDetailViewModel titleText];
    self.newsDescriptionLabel.text = @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
    
    self.pubDateLabel.backgroundColor = [UIColor redColor];
    self.newsImageView.backgroundColor = [UIColor greenColor];
    self.titleLabel.backgroundColor = [UIColor blueColor];
    self.newsDescriptionLabel.backgroundColor = [UIColor grayColor];
    
    [self.view setNeedsUpdateConstraints];
}

#pragma mark UIViewController template methods

- (void)updateViewConstraints
{
    if (!self.didSetConstraints) {
        self.didSetConstraints = YES;
        [self toggleConstraintsForTraitCollection:self.traitCollection];
    }
    [super updateViewConstraints];
}

#pragma mark - UIContentContainer protocol methods

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self toggleConstraintsForTraitCollection:newCollection];
}

#pragma mark Private methods

- (void)toggleConstraintsForTraitCollection:(UITraitCollection *)traitCollection {
    
    if ([traitCollection mk_matchesPhoneLandscape]) {
        [self uninstallPhonePortraitConstraints];
        [self installPhoneLandscapeConstraints];
    }
    else if ([traitCollection mk_matchesPhonePortrait]) {
        [self uninstallPhoneLandscapeConstraints];
        [self installPhonePortraitConstraints];
    }
    [self updateViewConstraints];
}

//portrait constraints
- (void)installPhonePortraitConstraints {
    
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.top.equalTo(self.mas_topLayoutGuide).with.offset(10)];
        [constraints addObject:make.leading.equalTo(self.view.mas_leading).with.offset(20)];
        [constraints addObject:make.trailing.equalTo(self.view.mas_trailing).with.offset(-20)];
    }];
    
    [self.newsImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10)];
        [constraints addObject:make.leading.trailing.equalTo(self.titleLabel)];
        [constraints addObject:make.bottom.equalTo(self.view.mas_centerY)];
    }];
    
    [self.pubDateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.top.equalTo(self.newsImageView.mas_bottom).with.offset(2)];
        [constraints addObject:make.leading.trailing.equalTo(self.newsImageView)];
        [constraints addObject:make.height.equalTo(@20)];
    }];
    
    [self.newsDescriptionLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.top.equalTo(self.pubDateLabel.mas_bottom).with.offset(6)];
        [constraints addObject:make.leading.trailing.equalTo(self.newsImageView)];
        [constraints addObject:make.bottom.lessThanOrEqualTo(self.view.mas_bottom).with.offset(-20)];
    }];
    
    self.phonePortraitConstraints = [constraints copy];
}

//landscape constraints
- (void)installPhoneLandscapeConstraints {
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.top.equalTo(self.mas_topLayoutGuide).with.offset(10)];
        [constraints addObject:make.leading.equalTo(self.view.mas_leading).with.offset(20)];
        [constraints addObject:make.trailing.equalTo(self.view.mas_trailing).with.offset(-20)];
    }];
    
    [self.newsImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10)];
        [constraints addObject:make.trailing.equalTo(self.view.mas_centerX)];
        [constraints addObject:make.leading.equalTo(self.titleLabel)];
        [constraints addObject:make.bottom.equalTo(self.view.mas_bottom).with.offset(-10)];
    }];
    
    [self.pubDateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.leading.equalTo(self.newsImageView.mas_trailing).with.offset(10)];
        [constraints addObject:make.trailing.equalTo(self.titleLabel)];
        [constraints addObject:make.bottom.equalTo(self.newsImageView)];
        [constraints addObject:make.height.equalTo(@20)];
        
    }];
    
    [self.newsDescriptionLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.leading.equalTo(self.pubDateLabel)];
        [constraints addObject:make.top.equalTo(self.newsImageView)];
        [constraints addObject:make.trailing.equalTo(self.titleLabel)];
        [constraints addObject:make.bottom.lessThanOrEqualTo(self.pubDateLabel.mas_top).with.offset(-6)];
    }];
    
    self.phoneLandscapeConstraints = [constraints copy];
}



- (void)uninstallPhonePortraitConstraints {
    for (MASConstraint *constraint in self.phonePortraitConstraints) {
        [constraint uninstall];
    }
}

- (void)uninstallPhoneLandscapeConstraints {
    for (MASConstraint *constraint in self.phoneLandscapeConstraints) {
        [constraint uninstall];
    }
}



@end
