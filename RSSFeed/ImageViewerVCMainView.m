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

@property (strong, nonatomic) UIScrollView* scrollView;
@property (strong, nonatomic) UITapGestureRecognizer* tapToZoom;
@property (strong, nonatomic) UITapGestureRecognizer* tapToDismissController;

@property BOOL didSetConstraints;
@property NSArray *iPadPortraitConstraints;
@property NSArray *phonePortraitConstraints;
@property NSArray *phoneLandscapeConstraints;

@end

@implementation ImageViewerVCMainView

-(UITapGestureRecognizer*) tapToDismissController {
    if (_tapToDismissController == nil) {
        _tapToDismissController = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        _tapToDismissController.delegate = self;
        _tapToDismissController.numberOfTapsRequired = 1;
    }
    return _tapToDismissController;
}

-(UITapGestureRecognizer*) tapToZoom {
    if (_tapToZoom == nil) {
        _tapToZoom = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        _tapToZoom.delegate = self;
        _tapToZoom.numberOfTapsRequired = 2;
    }
    return _tapToZoom;
}

//init with view model
- (instancetype)initWithViewModel:(ImageViewerViewModel*) viewModel;
{
    self = [super init];
    if (self) {
        _viewModel = viewModel;
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

// called once (viewDidLoad)
-(void) didMoveToSuperview {
    
    
    [self.viewModel prepareScrollView:^(UIScrollView *scrollView, UIImageView *imageView) {
        self.scrollView = scrollView;
        self.myImageView = imageView;
        
        self.scrollView.delegate = self;
        
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.myImageView];
        
        //gestures
        [self.scrollView addGestureRecognizer:self.tapToZoom];
        [self addGestureRecognizer:self.tapToDismissController];
    }];
}

#pragma mark - Scroll Methods

-(UIView*) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.myImageView;
}

-(CGFloat) normalZoomScale {
    CGFloat zoomScale = MIN(self.bounds.size.width / self.myImageView.image.size.width, self.bounds.size.height / self.myImageView.image.size.height);
    return zoomScale;
}

-(CGRect) zoomToRectWithPoint:(CGPoint) tapPoint {
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

-(void) handleSingleTap:(UITapGestureRecognizer*) tap {
    CGPoint location = [tap locationInView:self];
    CGPoint origin = CGPointMake(self.scrollView.center.x - self.scrollView.bounds.size.width / 2,
                                 self.scrollView.center.y - self.scrollView.bounds.size.height / 2);
    
    CGRect rect = CGRectMake(origin.x, origin.y, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    
    BOOL withinBounds = CGRectContainsPoint(rect, location);
    if (!withinBounds)
    {
        //delegate
        [self.delegate dismissViewController];
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
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.width.equalTo(self.mas_width)];
        [constraints addObject:make.center.equalTo(self)];
        [constraints addObject:make.height.equalTo(self.mas_height).multipliedBy(0.5)];
    }];
    
    [self.myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.width.height.equalTo(self.scrollView);
    }];
    
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
        [constraints addObject:make.edges.width.height.equalTo(self.scrollView)];
    }];
    
    self.phoneLandscapeConstraints = [constraints copy];
}

//iPad constraints (regular in all directions)
-(void) installIpadPortraitConstraints {
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.width.equalTo(self.mas_width)];
        [constraints addObject:make.center.equalTo(self)];
        [constraints addObject:make.height.equalTo(self.mas_height).multipliedBy(0.5)];
    }];
    
    [self.myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.width.height.equalTo(self.scrollView);
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
