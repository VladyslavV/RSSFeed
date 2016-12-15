//
//  ImageViewerVC.h
//  
//
//  Created by Vladysalv Vyshnevksyy on 12/14/16.
//
//

#import <UIKit/UIKit.h>
#import "ImageViewerViewModel.h"

@interface ImageViewerVC : UIViewController

@property (strong, nonatomic) UIImage* myImage;

- (instancetype)initWithViewModel:(ImageViewerViewModel*) viewModel;

@end
