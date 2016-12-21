//
//  Cities.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/20/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "Cities.h"

@implementation Cities

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"array" : @"list"
             };
}


+ (NSValueTransformer *) arrayJSONTransformer {
    return [MTLValueTransformer transformerUsingReversibleBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray* arr = value;
        return [MTLJSONAdapter modelsOfClass:[City class] fromJSONArray:arr error:error];
    }];
}

@end
