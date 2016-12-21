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

@implementation FetcherForWeather


-(void) fetchWetherWithStringURL:(NSString*) stringURL completion:(void (^) (Cities* model) ) callBack {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:stringURL
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             NSError *error = nil;
             Cities* cities = [MTLJSONAdapter modelOfClass:[Cities class]
                                              fromJSONDictionary:responseObject
                                                      error:&error];
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 callBack(cities);
             });
             
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             
             NSLog(@"Error: %@", error);
         }];
}

@end
