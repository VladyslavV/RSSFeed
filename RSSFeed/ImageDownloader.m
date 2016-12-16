//
//  ImageDownloader.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/14/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "ImageDownloader.h"


@implementation ImageDownloader

#pragma mark - Singleton

+ (instancetype)sharedObject {
    static id sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[[self class] alloc] init];
    });
    return sharedObject;
}


#pragma mark - Fetch Image

-(void) fetchImageWithUrl:(NSURL*) imgageUrl andCallBack:( void (^)(NSData* imageData)) completion {
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:imgageUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              if (error == nil) {
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      completion(data);
                                                  });
                                              }
                                          }];
    [downloadTask resume];
}

@end
