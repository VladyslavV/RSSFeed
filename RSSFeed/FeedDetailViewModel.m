//
//  FeedDetailViewlModel.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/9/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "FeedDetailViewModel.h"

@interface FeedDetailViewModel()

@end

@implementation FeedDetailViewModel

- (instancetype)initWithItem:(NewsItem*) newsItem
{
    self = [super init];
    if (self) {
        _newsItem = newsItem;
    }
    return self;
}


-(NSString*) titleText {
    return self.newsItem.title;
}

-(NSString*) newsDescriptionText {
    return self.newsItem.newsDescription;
}

-(NSString*) pubDateText {
    return self.newsItem.pubDate;
}

-(NSString*) imageURL {
    return self.newsItem.imageURL;
}

#pragma mark - Fetch image

-(void) fetchImageWithUrl:(NSString*) imgageUrl andCallBack:( void (^)(NSData* imageData)) completion {
    NSURL* url = [NSURL URLWithString:imgageUrl];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              
                                              if (error == nil) {
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      completion(data);
                                                  });
                                              }
                                          }];
    [downloadTask resume];
}


@end
