//
//  MantleModel.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/19/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
#import "MTLModel.h"
#import "Weather.h"

@interface City : MTLModel  <MTLJSONSerializing>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *country;

@property (strong, nonatomic) Weather* weather;

@property (nonatomic) float temperature;
@property (nonatomic) float humidity;
@property (nonatomic) float pressure;

@end
