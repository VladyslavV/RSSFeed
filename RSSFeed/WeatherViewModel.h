//
//  WeatherViewModel.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/19/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol WeatherViewModelDelegate <NSObject>

-(void) modelWasUpdated;

@end


@interface WeatherViewModel : NSObject <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, weak) id <WeatherViewModelDelegate> delegate;



-(void) loadWeatherFromWeb;
-(void) stopAllTasks;


@end
