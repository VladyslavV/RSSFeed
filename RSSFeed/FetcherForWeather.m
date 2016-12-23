//
//  FetcherForWeather.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/19/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "FetcherForWeather.h"

#import <AFNetworking.h>
#import "City.h"
#import "Cities.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface FetcherForWeather()

@property (strong, nonatomic) AFHTTPSessionManager* manager;

@end

@implementation FetcherForWeather

-(AFHTTPSessionManager*) manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}


-(void) fetchWetherWithStringURL:(NSString*) stringURL completion:(void (^) (Cities* model)) callBack failed:(void (^) (void)) failed {

    [SVProgressHUD showWithStatus:@"Loading..."];
    [self.manager GET:stringURL
           parameters:nil
             progress:^(NSProgress * _Nonnull downloadProgress) {
//                 NSLog(@"%lld", downloadProgress.totalUnitCount);
//                 NSLog(@"%f", downloadProgress.fractionCompleted );
//                 
//                 dispatch_async(dispatch_get_main_queue(), ^{
//                     //Update the progress view
//
//                     NSLog(@"%f", downloadProgress.fractionCompleted );
//                 });
                 
             }
              success:^(NSURLSessionTask *task, id responseObject) {
                  NSError *error = nil;
                  Cities* cities = [MTLJSONAdapter modelOfClass:[Cities class]
                                             fromJSONDictionary:responseObject
                                                          error:&error];
                  
                  [SVProgressHUD dismiss];
                  callBack(cities);
              } failure:^(NSURLSessionTask *operation, NSError *error) {
                  failed();
                  [SVProgressHUD dismiss];
                  NSLog(@"Error: %@", error);
              }];

}

-(void) cancelDownloading {
    [SVProgressHUD dismiss];
    [self.manager invalidateSessionCancelingTasks:YES];
}

@end
