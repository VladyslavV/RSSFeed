//
//  ImageViewerVC.h
//  
//
//  Created by Vladysalv Vyshnevksyy on 12/14/16.
//
//

#import <UIKit/UIKit.h>
#import "ImageViewerViewModel.h"
#import "ImageViewerVCMainView.h"

@interface ImageViewerVC : UIViewController <ImageViewerVCMainViewDelegate>

- (instancetype)initWithViewModel:(ImageViewerViewModel*) viewModel;

@end
