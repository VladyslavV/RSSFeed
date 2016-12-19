//
//  ImageViewerViewModel.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/14/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "ImageViewerViewModel.h"
#import "ImageDownloader.h"

@interface ImageViewerViewModel()

@property (strong, nonatomic, readwrite) NSURL* imageURL;


@property (strong, nonatomic) UIImageView* myImageView;

@property (strong, nonatomic) UIScrollView* scrollView;

@end

@implementation ImageViewerViewModel

- (instancetype)initWithURL:(NSURL*) imageURL
{
    self = [super init];
    if (self) {
        self.imageURL = imageURL;
    }
    return self;
}

- (instancetype)initWithImage:(UIImage*) image
{
    self = [super init];
    if (self) {
        self.myImageView.image = image;
    }
    return self;
}

-(void) prepareScrollView:(void (^) (UIScrollView* scrollView, UIImageView* imageView)) callBack {
    callBack(self.scrollView, self.myImageView);
}

-(UIScrollView*) scrollView {
    if (_scrollView == nil) {
        _scrollView = [UIScrollView new];
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.maximumZoomScale = 3.0;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.contentMode = UIViewContentModeScaleAspectFit;
        _scrollView.backgroundColor = [UIColor lightGrayColor];
    }
    return _scrollView;
}

-(UIImageView*) myImageView {
    if (_myImageView == nil) {
        _myImageView = [UIImageView new];
        _myImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _myImageView.userInteractionEnabled = YES;
       // _myImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _myImageView;
}




@end
