//
//  MantleModel.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/19/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "City.h"

@implementation City


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name": @"name",
             @"weather" : @"weather",
             @"temperature": @"main.temp",
             @"humidity" : @"main.humidity",
             @"pressure" : @"main.pressure",
             @"country" : @"sys.country"
             };
}

+ (NSValueTransformer *) weatherJSONTransformer {
    return [MTLValueTransformer transformerUsingReversibleBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray* arr = value;
        return [MTLJSONAdapter modelOfClass:[Weather class] fromJSONDictionary:arr.firstObject error:error];
    }];
}

@end
