//
//  Realm.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/22/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm.h>
#import "Cities.h"

RLM_ARRAY_TYPE(DBCityRealm)

@interface DBCityRealm : RLMObject

+ (void) clearRealm;
+ (void) createDBModelWithMantleModel:(Cities*) mantleCities;


@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *country;

@property (nonatomic) float temperature;
@property (nonatomic) float humidity;
@property (nonatomic) float pressure;


//in weather mantle class
@property (copy, nonatomic) NSString* condition;
@property (copy, nonatomic) NSString* detailed;
@property (copy, nonatomic) NSString* icon;

@end
