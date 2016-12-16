//
//  ImageViewerViewModel.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/14/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageViewerViewModel : NSObject

- (instancetype)initWithImage:(UIImage*) image;

-(void) prepareScrollView:(void (^) (UIScrollView* scrollView, UIImageView* imageView)) callBack;

@end
