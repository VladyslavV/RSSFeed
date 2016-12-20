//
//  Weather.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/20/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "Weather.h"

@implementation Weather

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"condition": @"main",
             @"detailed" : @"description",
             @"theID" : @"id",
             @"icon" : @"icon"
             };
}


@end
