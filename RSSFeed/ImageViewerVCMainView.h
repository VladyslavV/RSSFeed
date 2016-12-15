//
//  ImageViewerVCMainView.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/14/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageViewerViewModel.h"

@interface ImageViewerVCMainView : UIView <UIScrollViewDelegate, UIGestureRecognizerDelegate>

- (instancetype)initWithViewModel:(ImageViewerViewModel*) viewModel;

// update constraints
- (void)toggleConstraintsForTraitCollection:(UITraitCollection *)traitCollection;


@end
