//
//  FetcherForWeather.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/19/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cities.h"

@interface FetcherForWeather : NSObject

-(void) fetchWetherWithStringURL:(NSString*) stringURL completion:(void (^) (Cities* model)) callBack failed:(void (^) (void)) failed;

-(void) cancelDownloading;


@end
