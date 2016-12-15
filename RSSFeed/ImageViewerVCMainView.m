//
//  ImageViewerVCMainView.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/14/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "ImageViewerVCMainView.h"
#import "UITraitCollection+MKAdditions.h"
#import "Masonry.h"
#import "ImageDownloader.h"

@interface ImageViewerVCMainView ()

@property (strong, nonatomic) ImageViewerViewModel* viewModel;

@property (strong, nonatomic) UIImageView* myImageView;
@property (strong, nonatomic) UIVisualEffectView* blurEffectView;
@property (strong, nonatomic) UIButton* dismissController;

@property (strong, nonatomic) UIScrollView* scrollView;
@property (strong, nonatomic) UITapGestureRecognizer* tapGestureRecognizer;

@property BOOL didSetConstraints;
@property NSArray *iPadPortraitConstraints;
@property NSArray *phonePortraitConstraints;
@property NSArray *phoneLandscapeConstraints;

@end

@implementation ImageViewerVCMainView

@synthesize scrollView = _scrollView;


-(UITapGestureRecognizer*) tapGestureRecognizer {
    if (_tapGestureRecognizer == nil) {
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        _tapGestureRecognizer.delegate = self;
        _tapGestureRecognizer.numberOfTapsRequired = 2;
    }
    return _tapGestureRecognizer;
}

-(UIScrollView*) scrollView {
    if (_scrollView == nil) {
        _scrollView = [UIScrollView new];
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        _scrollView.minimumZoomScale = 0.5;
        _scrollView.maximumZoomScale = 2.0;
        _scrollView.delegate = self;
        _scrollView.userInteractionEnabled = YES;
    }
    return _scrollView;
}

-(UIVisualEffectView*) blurEffectView {
    if (_blurEffectView == nil) {
        UIVisualEffect* blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        _blurEffectView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _blurEffectView;
}

-(UIImageView*) myImageView {
    if (_myImageView == nil) {
        _myImageView = [UIImageView new];
        _myImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _myImageView;
}


//init with view model
- (instancetype)initWithViewModel:(ImageViewerViewModel*) viewModel;
{
    self = [super init];
    if (self) {
        _viewModel = viewModel;
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

-(void) layoutSubviews {
    [self updateZoomToNormal];
}


-(void) didMoveToSuperview {
    [self addSubview:self.scrollView];
    
    [self.viewModel setImage:self.myImageView forScrollView:self.scrollView];
    [self addGestureRecognizer:self.tapGestureRecognizer];
    
    // [self addSubview:self.blurEffectView];
    //[self.blurEffectView addSubview:self.myImageView];
    //[self.viewModel setImage:self.myImageView];
}

#pragma mark - Scroll Methods

-(UIView*) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.myImageView;
}

- (void)updateZoomToNormal {
    float zoomScale = [self normalZoomScale];
    if (zoomScale > 1) {
        self.scrollView.minimumZoomScale = 1;
    }
    self.scrollView.minimumZoomScale = zoomScale;
    self.scrollView.zoomScale = zoomScale;
}

-(CGFloat) normalZoomScale {
    CGFloat zoomScale = MIN(self.bounds.size.width / self.myImageView.image.size.width, self.bounds.size.height / self.myImageView.image.size.height);
    return zoomScale;
}

-(CGRect) zoomToRectWithPoint:(CGPoint) tapPoint {
    //CGFloat scale = MIN(self.scrollView.zoomScale * 2, self.scrollView.maximumZoomScale);
    CGFloat scale = self.scrollView.maximumZoomScale; // zoom very close
    CGSize scrollSize = self.scrollView.frame.size;
    CGPoint point = tapPoint;
    CGSize size = CGSizeMake(scrollSize.width / scale, scrollSize.height / scale);
    CGPoint origin = CGPointMake(point.x - size.width / 2, point.y - size.height / 2);
    CGRect rect = CGRectMake(origin.x, origin.y, size.width, size.height);
    
    return rect;
}

#pragma mark - Actions

-(void) handleDoubleTap:(UITapGestureRecognizer*) tap {
    if (self.scrollView.zoomScale > 1) {
        [self.scrollView setZoomScale:[self normalZoomScale] animated:YES];
    } else {
        [self.scrollView zoomToRect:[self zoomToRectWithPoint:[tap locationInView:self.myImageView]] animated:YES];
    }
}

#pragma mark - Constraints

- (void)updateConstraints
{
    if (!self.didSetConstraints) {
        self.didSetConstraints = YES;
        [self toggleConstraintsForTraitCollection:self.traitCollection];
    }
    [super updateConstraints];
}



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
    
    [self.myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.edges.equalTo(self.scrollView)];
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.width.equalTo(self.mas_width)];
        [constraints addObject:make.center.equalTo(self)];
        [constraints addObject:make.height.equalTo(self.mas_height).multipliedBy(0.5)];
    }];
    
    //    [self.blurEffectView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        [constraints addObject:make.edges.equalTo(self)];
    //    }];
    
    self.phonePortraitConstraints = [constraints copy];
}

//landscape constraints
- (void)installPhoneLandscapeConstraints {
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    [self.scrollView  mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.width.equalTo(self.mas_width).multipliedBy(0.6)];
        [constraints addObject:make.center.equalTo(self)];
        [constraints addObject:make.height.equalTo(self.mas_height)];
    }];
    
    [self.myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.edges.equalTo(self.scrollView)];
    }];
    
    self.phoneLandscapeConstraints = [constraints copy];
}

//iPad constraints (regular in all directions)
-(void) installIpadPortraitConstraints {
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    [self.myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.edges.equalTo(self.scrollView)];
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.width.equalTo(self.mas_width)];
        [constraints addObject:make.center.equalTo(self)];
        [constraints addObject:make.height.equalTo(self.mas_height).multipliedBy(0.5)];
    }];
    
    self.iPadPortraitConstraints = [constraints copy];
}

//uninstall constraints
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
