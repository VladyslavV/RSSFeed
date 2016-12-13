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

@interface FeedViewDetailMainView()

@property BOOL didSetConstraints;
@property NSArray *iPadPortraitConstraints;
@property NSArray *phonePortraitConstraints;
@property NSArray *phoneLandscapeConstraints;

@end

@implementation FeedViewDetailMainView


-(NSAttributedString*) getAttributedString:(NSString*) oldString {
    NSMutableAttributedString* newString = [[NSMutableAttributedString alloc] initWithString:oldString];
    
    [newString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, oldString.length)];
    [newString addAttribute:NSStrokeWidthAttributeName value:@-10.0 range:NSMakeRange(0, oldString.length) ];
    return newString;
}

-(UIBarButtonItem*) barButtonOpenInSafari {
    if (_barButtonOpenInSafari == nil) {
        _barButtonOpenInSafari = [[UIBarButtonItem alloc] init];
        _barButtonOpenInSafari.title = @"Open in Safari";
    }
    return _barButtonOpenInSafari;
}

-(UIImageView*) newsImageView {
    if (_newsImageView == nil) {
        _newsImageView = [UIImageView new];
        _newsImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [_newsImageView setContentMode:UIViewContentModeScaleToFill];
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
        [_newsDescriptionLabel setFont:[UIFont systemFontOfSize:22]];
        [_newsDescriptionLabel sizeToFit];
        _newsDescriptionLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _newsDescriptionLabel;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.newsImageView];
        [self addSubview:self.pubDateLabel];
        [self addSubview:self.newsDescriptionLabel];
        [self setNeedsUpdateConstraints];
    }
    return self;
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
        [constraints addObject:make.bottom.lessThanOrEqualTo(self.mas_bottom).with.offset(-20)];
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
        [constraints addObject:make.bottom.lessThanOrEqualTo(self.pubDateLabel.mas_top).with.offset(-6)];
    }];
    
    self.phoneLandscapeConstraints = [constraints copy];
}

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
        //[constraints addObject:make.trailing.equalTo(self.view.mas_centerX)];
        [constraints addObject:make.leading.equalTo(self.mas_leading).with.offset(20)];
        //[constraints addObject:make.bottom.equalTo(self.view.mas_centerY).with.offset];
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


@end
