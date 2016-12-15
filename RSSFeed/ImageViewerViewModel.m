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

-(NSURL*) getImageURL {
    return self.imageURL;
}

-(void) setImage:(UIImageView*) imageView forScrollView:(UIScrollView*) scrollView {
    [[ImageDownloader sharedObject] fetchImageWithUrl:self.imageURL andCallBack:^(NSData *imageData) {
        UIImage* image = [[UIImage alloc] initWithData:imageData];
        imageView.image = image;
        scrollView.contentSize = image.size;
        scrollView.contentMode = UIViewContentModeScaleAspectFit;
        [scrollView addSubview:imageView];
    }];
}


@end
