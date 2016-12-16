//
//  FeedViewDetailMainView.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/12/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "FeedViewDetailMainView.h"
#import "Masonry.h"
#import "UITraitCollection+MKAdditions.h"
#import "ImageDownloader.h"

@interface FeedViewDetailMainView()

@property (strong, nonatomic) FeedDetailViewModel* feedDetailViewModel;

@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UILabel* newsDescriptionLabel;
@property (strong, nonatomic) UILabel* pubDateLabel;

@property (strong, nonatomic) UIButton* shareSocialButton;

@property (strong, nonatomic) UIVisualEffectView* blurView;

@property BOOL didSetConstraints;
@property NSArray *iPadPortraitConstraints;
@property NSArray *phonePortraitConstraints;
@property NSArray *phoneLandscapeConstraints;

@property (strong, nonatomic) UITapGestureRecognizer* tapGestureRecognizer;

@end

@implementation FeedViewDetailMainView

static void * XXContext = &XXContext;

#pragma mark - Create Views

-(UIButton*) shareSocialButton {
    if (_shareSocialButton == nil) {
        _shareSocialButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _shareSocialButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_shareSocialButton addTarget:self action:@selector(shareToSocialMedia:) forControlEvents:UIControlEventTouchUpInside];
        [_shareSocialButton setTitle:NSLocalizedString(@"share.to.socialmedia", nil) forState:UIControlStateNormal];
        [_shareSocialButton.layer setBorderWidth:2.0f];
        _shareSocialButton.layer.masksToBounds = YES;
        _shareSocialButton.clipsToBounds = YES;
        UIColor *lightBlueColor = [UIColor colorWithRed:102.0/255.0 green:178.0/255.0 blue:255.0/255.0 alpha:1.0];
        [_shareSocialButton setTitleColor:lightBlueColor forState:UIControlStateNormal];
        [[_shareSocialButton layer] setBorderColor:lightBlueColor.CGColor];
        [_shareSocialButton addObserver:self
                             forKeyPath:NSStringFromSelector(@selector(bounds))
                                options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionPrior
                                context:XXContext];
    }
    return _shareSocialButton;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == XXContext) {
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(bounds))]) {
            self.shareSocialButton.layer.cornerRadius = self.shareSocialButton.frame.size.width / 10.0f;
        }
    }
    
}

-(UIVisualEffectView*) blurView {
    if (_blurView == nil) {
        UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];;
        _blurView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _blurView;
}

-(UITapGestureRecognizer*) tapGestureRecongnizer {
    if (_tapGestureRecognizer == nil) {
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
        [_tapGestureRecognizer addTarget:self action:@selector(handleTapFrom:)];
        _tapGestureRecognizer.delegate = self;
    }
    return _tapGestureRecognizer;
}

-(NSAttributedString*) getAttributedString:(NSString*) oldString {
    NSMutableAttributedString* newString = [[NSMutableAttributedString alloc] initWithString:oldString];
    [newString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, oldString.length)];
    [newString addAttribute:NSStrokeWidthAttributeName value:@-10.0 range:NSMakeRange(0, oldString.length) ];
    return newString;
}

-(UIBarButtonItem*) barButtonOpenInSafari {
    if (_barButtonOpenInSafari == nil) {
        _barButtonOpenInSafari = [[UIBarButtonItem alloc] init];
        _barButtonOpenInSafari.title = NSLocalizedString(@"navigation.bar.openinbrowser", nil);
    }
    return _barButtonOpenInSafari;
}

-(UIImageView*) newsImageView {
    if (_newsImageView == nil) {
        _newsImageView = [UIImageView new];
        _newsImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [_newsImageView setContentMode:UIViewContentModeScaleToFill];
        [_newsImageView setUserInteractionEnabled:YES];
    }
    return _newsImageView;
}

-(UILabel*) pubDateLabel {
    if (_pubDateLabel == nil) {
        _pubDateLabel = [UILabel new];
        _pubDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_pubDateLabel sizeToFit];
        [_pubDateLabel setFont:[UIFont systemFontOfSize:10]];
        _pubDateLabel.adjustsFontSizeToFitWidth = YES;
        _pubDateLabel.numberOfLines = 0;
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
        UIFont* font = [UIFont systemFontOfSize:22];
        [_newsDescriptionLabel setFont:font];
        [_newsDescriptionLabel sizeToFit];
        _newsDescriptionLabel.minimumScaleFactor = 12.0 / font.pointSize;
        _newsDescriptionLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _newsDescriptionLabel;
}

#pragma mark - Initializer

- (instancetype)initWithModel:(FeedDetailViewModel*) model
{
    self = [super init];
    if (self) {
        self.feedDetailViewModel = model;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.newsImageView];
        [self addSubview:self.pubDateLabel];
        [self addSubview:self.newsDescriptionLabel];
        [self addSubview:self.shareSocialButton];
        
        self.barButtonOpenInSafari.target = self;
        self.barButtonOpenInSafari.action = @selector(openInSafari);
        self.titleLabel.attributedText = [self getAttributedString:[self.feedDetailViewModel titleText]];
        self.newsDescriptionLabel.text = [self.feedDetailViewModel newsDescriptionText];
        self.pubDateLabel.text = [self.feedDetailViewModel pubDateText];
        
        
        [[ImageDownloader sharedObject] fetchImageWithUrl:self.feedDetailViewModel.imageURL andCallBack:^(NSData *imageData) {
            UIImage* image = [UIImage imageWithData:imageData];
            self.newsImageView.image = image;
        }];
        
        [self.newsImageView addGestureRecognizer:self.tapGestureRecongnizer];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

#pragma mark - User Actions

- (void) handleTapFrom: (UITapGestureRecognizer *)recognizer {
    [self.delegate imageTapped];
}

-(void) openInSafari {
    [[UIApplication sharedApplication] openURL:[self.feedDetailViewModel newsLink]
                                       options:@{}
                             completionHandler:nil];
}

-(void) addBlurView {
    [self addSubview:self.blurView];
    [self.blurView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

-(void) removeBlurView {
    [self.blurView removeFromSuperview];
}

-(void) shareToSocialMedia:(UIButton*) sender {
    [self.delegate shareToMedia:[self.feedDetailViewModel newsLink]];
}

#pragma mark - UIViewController template methods

- (void)updateConstraints
{
    if (!self.didSetConstraints) {
        self.didSetConstraints = YES;
        [self toggleConstraintsForTraitCollection:self.traitCollection];
    }
    [super updateConstraints];
}

#pragma mark Private methods

- (void)toggleConstraintsForTraitCollection:(UITraitCollection *)traitCollection {
    
    if ([traitCollection mk_matchesIpadPortrait]) {
        [self uninstallPhonePortraitConstraints];
        [self uninstallPhoneLandscapeConstraints];
        [self installIpadPortraitConstraints];
    }
    else if ([traitCollection mk_matchesPhoneLandscape]) {
        [self uninstallPhonePortraitConstraints];
        [self installPhoneLandscapeConstraints];
    }
    else if ([traitCollection mk_matchesPhonePortrait]) {
        [self uninstallPhoneLandscapeConstraints];
        [self installPhonePortraitConstraints];
    }
    [self updateConstraints];
}

//portrait constraints
- (void)installPhonePortraitConstraints {
    
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.top.equalTo(self.mas_top).with.offset(10)];
        [constraints addObject:make.leading.equalTo(self.mas_leading).with.offset(20)];
        [constraints addObject:make.trailing.equalTo(self.mas_trailing).with.offset(-20)];
        [constraints addObject:make.height.greaterThanOrEqualTo(@40)];
    }];
    
    [self.newsImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10)];
        [constraints addObject:make.leading.trailing.equalTo(self.titleLabel)];
        [constraints addObject:make.bottom.equalTo(self.mas_centerY)];
    }];
    
    [self.pubDateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.top.equalTo(self.newsImageView.mas_bottom).with.offset(2)];
        [constraints addObject:make.leading.trailing.equalTo(self.newsImageView)];
        [constraints addObject:make.height.lessThanOrEqualTo(@20)];
    }];
    
    [self.newsDescriptionLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.top.equalTo(self.pubDateLabel.mas_bottom).with.offset(6)];
        [constraints addObject:make.leading.trailing.equalTo(self.newsImageView)];
        [constraints addObject:make.bottom.lessThanOrEqualTo(self.shareSocialButton.mas_top).with.offset(-20)];
    }];
    
    [self.shareSocialButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.centerX.equalTo(self.mas_centerX)];
        [constraints addObject:make.width.equalTo(self.mas_width).multipliedBy(0.4)];
        [constraints addObject:make.height.equalTo(self.mas_height).multipliedBy(0.1)];
        [constraints addObject:make.bottom.equalTo(self.mas_bottom).with.offset(-30)];
    }];
    
    
    self.phonePortraitConstraints = [constraints copy];
}

//landscape constraints
- (void)installPhoneLandscapeConstraints {
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.top.equalTo(self.mas_top).with.offset(10)];
        [constraints addObject:make.leading.equalTo(self.mas_leading).with.offset(20)];
        [constraints addObject:make.trailing.equalTo(self.mas_trailing).with.offset(-20)];
        [constraints addObject:make.height.greaterThanOrEqualTo(@30)];
    }];
    
    [self.newsImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10)];
        [constraints addObject:make.trailing.equalTo(self.mas_centerX)];
        [constraints addObject:make.leading.equalTo(self.titleLabel)];
        [constraints addObject:make.bottom.equalTo(self.mas_bottom).with.offset(-10)];
    }];
    
    [self.pubDateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.leading.equalTo(self.newsImageView.mas_trailing).with.offset(10)];
        [constraints addObject:make.trailing.equalTo(self.titleLabel)];
        [constraints addObject:make.bottom.equalTo(self.newsImageView)];
        [constraints addObject:make.height.lessThanOrEqualTo(@20)];
        
    }];
    
    [self.newsDescriptionLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.leading.equalTo(self.pubDateLabel)];
        [constraints addObject:make.top.equalTo(self.newsImageView)];
        [constraints addObject:make.trailing.equalTo(self.titleLabel)];
        [constraints addObject:make.bottom.lessThanOrEqualTo(self.shareSocialButton.mas_top).with.offset(-6)];
    }];
    
    [self.shareSocialButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.centerX.equalTo(self.newsDescriptionLabel.mas_centerX)];
        [constraints addObject:make.width.equalTo(self).multipliedBy(0.2)];
        [constraints addObject:make.height.equalTo(self).multipliedBy(0.1)];
        [constraints addObject:make.bottom.equalTo(self.pubDateLabel.mas_top).with.offset(-10)];
    }];
    
    self.phoneLandscapeConstraints = [constraints copy];
}

//iPad constraints (regular in all directions)
-(void) installIpadPortraitConstraints {
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.top.equalTo(self.mas_top).with.offset(10)];
        [constraints addObject:make.leading.equalTo(self.mas_leading).with.offset(20)];
        [constraints addObject:make.trailing.equalTo(self.mas_trailing).with.offset(-20)];
        [constraints addObject:make.height.greaterThanOrEqualTo(@30)];
    }];
    
    [self.newsImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10)];
        [constraints addObject:make.width.height.equalTo(self.mas_height).multipliedBy(0.4)];
        [constraints addObject:make.leading.equalTo(self.mas_leading).with.offset(20)];
    }];
    
    [self.pubDateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.top.equalTo(self.newsImageView.mas_bottom).with.offset(2)];
        [constraints addObject:make.leading.trailing.equalTo(self.newsImageView)];
        [constraints addObject:make.height.lessThanOrEqualTo(@20)];
    }];
    
    [self.newsDescriptionLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.leading.equalTo(self.newsImageView.mas_trailing).with.offset(10)];
        [constraints addObject:make.top.equalTo(self.newsImageView)];
        [constraints addObject:make.trailing.equalTo(self.mas_trailing).with.offset(-20)];
        [constraints addObject:make.bottom.lessThanOrEqualTo(self.pubDateLabel.mas_top).with.offset(-6)];
    }];
    
    [self.shareSocialButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.centerX.equalTo(self.mas_centerX)];
        [constraints addObject:make.width.equalTo(self.mas_width).multipliedBy(0.4)];
        [constraints addObject:make.height.equalTo(self.mas_height).multipliedBy(0.1)];
        [constraints addObject:make.bottom.equalTo(self.mas_bottom).with.offset(-30)];
    }];
    
    self.iPadPortraitConstraints = [constraints copy];
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

#pragma mark - Dealloc

-(void)dealloc {
    [self.shareSocialButton removeObserver:self forKeyPath:@"bounds"];
}

@end
