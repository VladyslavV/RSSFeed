//
//  ImageViewerVCMainView.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/14/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageViewerViewModel.h"

@protocol ImageViewerVCMainViewDelegate <NSObject>

-(void) dismissViewController;

@end

@interface ImageViewerVCMainView : UIView <UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property(weak, nonatomic) id <ImageViewerVCMainViewDelegate> delegate;

- (instancetype)initWithViewModel:(ImageViewerViewModel*) viewModel;

// update constraints
- (void)toggleConstraintsForTraitCollection:(UITraitCollection *)traitCollection;


@end
