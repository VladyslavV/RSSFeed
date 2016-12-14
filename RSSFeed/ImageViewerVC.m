//
//  ImageViewerVC.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/13/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "ImageViewerVC.h"
#import "Masonry.h"

@interface ImageViewerVC () <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIImageView* myImageView;
@property (strong, nonatomic) UIImage* image;

@property (strong, nonatomic) UITapGestureRecognizer* tapGestureRecognizer;
@property (strong, nonatomic) UIPinchGestureRecognizer* pinchGestureRecognizer;


@end

@implementation ImageViewerVC

CGFloat lastScale;

-(UIImageView*) myImageView {
    if (_myImageView == nil) {
        _myImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _myImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [_myImageView setContentMode:UIViewContentModeScaleToFill];
        _myImageView.userInteractionEnabled = YES;
        [self.view addSubview:_myImageView];
    }
    return _myImageView;
}

-(UIPinchGestureRecognizer*) pinchGestureRecognizer {
    if (_pinchGestureRecognizer == nil) {
        _pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] init];
        [_pinchGestureRecognizer addTarget:self action:@selector(handlePinch:)];
        _pinchGestureRecognizer.delegate = self;
    }
    return _pinchGestureRecognizer;
}

-(UITapGestureRecognizer*) tapGestureRecognizer {
    if (_tapGestureRecognizer == nil) {
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
        [_tapGestureRecognizer addTarget:self action:@selector(handleTapFrom:)];
        _tapGestureRecognizer.delegate = self;
    }
    return _tapGestureRecognizer;
}

#pragma mark - Init & LifeCycle

- (instancetype)initWithImage:(UIImage*) image;
{
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated  {
    self.myImageView.image = self.image;
    [self.myImageView addGestureRecognizer:self.tapGestureRecognizer];
    [self.myImageView addGestureRecognizer:self.pinchGestureRecognizer];
}



#pragma mark - Handle Actions

-(void) handleTapFrom:(UITapGestureRecognizer*) tap {
    tap.numberOfTapsRequired = 2;
    NSLog(@"go");
}

-(void) handlePinch:(UIPinchGestureRecognizer*) pinch {
    
    if([self.pinchGestureRecognizer state] == UIGestureRecognizerStateBegan) {
        // Reset the last scale, necessary if there are multiple objects with different scales.
        lastScale = [self.pinchGestureRecognizer scale];
    }
    
    if ([self.pinchGestureRecognizer state] == UIGestureRecognizerStateBegan ||
        [self.pinchGestureRecognizer state] == UIGestureRecognizerStateChanged) {
        
        CGFloat currentScale = [[[self.pinchGestureRecognizer view].layer valueForKeyPath:@"transform.scale"] floatValue];
        
        // Constants to adjust the max/min values of zoom.
        const CGFloat kMaxScale = 2.0;
        const CGFloat kMinScale = 1.0;
        
        CGFloat newScale = 1 -  (lastScale - [self.pinchGestureRecognizer scale]); // new scale is in the range (0-1)
        newScale = MIN(newScale, kMaxScale / currentScale);
        newScale = MAX(newScale, kMinScale / currentScale);
        CGAffineTransform transform = CGAffineTransformScale([[self.pinchGestureRecognizer view] transform], newScale, newScale);
        [self.pinchGestureRecognizer view].transform = transform;
        
        lastScale = [self.pinchGestureRecognizer scale];  // Store the previous. scale factor for the next pinch gesture call
    }
}





@end
