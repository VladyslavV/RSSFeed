//
//  WeatherViewModel.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/19/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "WeatherViewModel.h"
#import "FetcherForWeather.h"
#import "WeatherCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "DBCityRealm.h"

@interface WeatherViewModel()

@property (strong, nonatomic) FetcherForWeather* fetcher;
@property (strong, nonatomic) Cities* model;


@property (strong, nonatomic) RLMResults<DBCityRealm *> *realmCities;

@end

@implementation WeatherViewModel

NSString* stringURL = @"http://api.openweathermap.org/data/2.5/group?id=706483,6942553,2147714,5128581,524901,703448,2643743,4927854,4539726,4561542,4188377,4921476,107968&units=metric&appid=4024a343a62743770c16424ec74479c6";

-(void)setModel:(Cities *)model {
    _model = model;
    
#warning Realm
    [DBCityRealm clearRealm];
    [DBCityRealm createDBModelWithMantleModel:self.model];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.realmCities = [DBCityRealm allObjects];
    });
}

-(void)setRealmCities:(RLMResults<DBCityRealm *> *)realmCities {
    _realmCities = realmCities;
    [self.delegate modelWasUpdated];
}

-(FetcherForWeather*) fetcher {
    if (!_fetcher) {
        _fetcher = [FetcherForWeather new];
    }
    return _fetcher;
}

-(void) loadWeatherFromWeb {
    [self.fetcher fetchWetherWithStringURL:stringURL completion:^(Cities *model) {
        self.model = model;
    } failed:^ {
        self.model = nil;
    }];
}


#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.realmCities? self.realmCities.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeatherCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherCell"];
    //City* city = self.model.array[indexPath.row];
    
    if (self.realmCities) {
        DBCityRealm* city = self.realmCities[indexPath.row];
        
        cell.cityLabel.text = [NSString stringWithFormat:@"%@, %@", city.name, city.country];
        cell.temperatureLabel.text =  [NSString stringWithFormat:@"Tempreture: %ld°C ", lroundf(city.temperature)];
        cell.humidityLabel.text = [NSString stringWithFormat:@"Humidity: %ld", lroundf(city.humidity)];
        cell.conditionLabel.text = [NSString stringWithFormat:@"Condition: %@", city.condition];
        //capitalize first letter
        NSString* description = [city.detailed stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[city.detailed substringToIndex:1] uppercaseString]];
        cell.detailLabel.text = [NSString stringWithFormat:@"Description: %@", description];
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(WeatherCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // City* city = self.model.array[indexPath.row];
    
    if (self.realmCities) {
        DBCityRealm* city = self.realmCities[indexPath.row];
        
        NSString * stringURL = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", city.icon];
        //set aspect fit for the placeholder
        [cell.weatherIconImageView setContentMode:UIViewContentModeScaleAspectFit];
        cell.weatherIconImageView.image = nil;
        [cell.weatherIconImageView sd_setImageWithURL:[NSURL URLWithString:stringURL]placeholderImage:[UIImage imageNamed:@"weatherPlaceholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [cell.weatherIconImageView setContentMode:UIViewContentModeCenter];
        }];
        
     
    }
}

-(void) stopAllTasks {
    [self.fetcher cancelDownloading];
}








@end
