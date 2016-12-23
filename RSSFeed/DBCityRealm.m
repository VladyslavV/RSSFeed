//
//  Realm.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/22/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "DBCityRealm.h"

@implementation DBCityRealm

+ (void) clearRealm {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
}

+ (void) createDBModelWithMantleModel:(Cities*) mantleCities {
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    for (City* mantleCity in mantleCities.array) {
        
        DBCityRealm* realmCity =[DBCityRealm new];
        realmCity.name = mantleCity.name;
        realmCity.country = mantleCity.country;
        realmCity.temperature = mantleCity.temperature;
        realmCity.pressure = mantleCity.pressure;
        realmCity.humidity = mantleCity.humidity;
        realmCity.icon = mantleCity.weather.icon;
        realmCity.condition = mantleCity.weather.condition;
        realmCity.detailed = mantleCity.weather.detailed;
        
        [realm beginWriteTransaction];
        [realm addObject:realmCity];
        [realm commitWriteTransaction];
    }
}


@end
