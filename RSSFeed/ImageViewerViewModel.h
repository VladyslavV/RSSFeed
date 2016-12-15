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


- (instancetype)initWithURL:(NSURL*) imageURL;


-(void) setImage:(UIImageView*) imageView forScrollView:(UIScrollView*) scrollView;

@end
