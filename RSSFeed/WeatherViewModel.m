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

@interface WeatherViewModel()

@property (strong, nonatomic) FetcherForWeather* fetcher;
@property (strong, nonatomic) Cities* model;

@end

@implementation WeatherViewModel

NSString* stringURL = @"http://api.openweathermap.org/data/2.5/group?id=706483,6942553,2147714,5128581,524901,703448,2643743&units=metric&appid=4024a343a62743770c16424ec74479c6";

-(void)setModel:(Cities *)model {
    _model = model;
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
    return self.model.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeatherCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherCell"];
    City* city = self.model.array[indexPath.row];
    cell.cityLabel.text = [NSString stringWithFormat:@"%@, %@", city.name, city.country];
    cell.temperatureLabel.text =  [NSString stringWithFormat:@"Temp: %ld°C ", lroundf(city.temperature)];
    cell.humidityLabel.text = [NSString stringWithFormat:@"Humidity: %ld", lroundf(city.humidity)];
    cell.conditionLabel.text = [NSString stringWithFormat:@"Condition: %@", city.weather.condition];
    //capitalize first letter
    NSString* description = [city.weather.detailed stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[city.weather.detailed substringToIndex:1] uppercaseString]];
    cell.detailLabel.text = [NSString stringWithFormat:@"Description: %@", description];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(WeatherCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    City* city = self.model.array[indexPath.row];
    NSString * stringURL = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", city.weather.icon];
    cell.weatherIconImageView.image = nil;
    [cell.weatherIconImageView sd_setImageWithURL:[NSURL URLWithString:stringURL]placeholderImage:[UIImage imageNamed:@"weatherPlaceholder"]];
}






@end
