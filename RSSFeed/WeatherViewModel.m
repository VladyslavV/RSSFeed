//
//  WeatherViewModel.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/19/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "WeatherViewModel.h"
#import "FetcherForWeather.h"

@interface WeatherViewModel()

@property (strong, nonatomic) FetcherForWeather* fetcher;
@property (strong, nonatomic) Cities* model;

@end

@implementation WeatherViewModel

NSString* stringURL = @"http://api.openweathermap.org/data/2.5/group?id=524901,703448,2643743&units=metric&appid=4024a343a62743770c16424ec74479c6";

-(void)setModel:(Cities *)model {
    _model = model;
    NSLog(@"%@", self.model.array[1]);

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
    }];
}


@end
