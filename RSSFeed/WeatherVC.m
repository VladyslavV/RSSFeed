//
//  WeatherVC.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/19/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "WeatherVC.h"
#import <AFNetworking.h>
#import "WeatherMainView.h"
#import "WeatherViewModel.h"

@interface WeatherVC () <WeatherViewModelDelegate>

@property (strong, nonatomic) WeatherMainView* mainView;

@property (strong, nonatomic) WeatherViewModel* viewModel;

@end

@implementation WeatherVC

#pragma mark - Create

-(WeatherMainView*) mainView {
    if (!_mainView) {
        _mainView = [WeatherMainView new];
        _mainView.translatesAutoresizingMaskIntoConstraints = NO;
        _mainView.viewModel = self.viewModel;
    }
    return _mainView;
}

-(WeatherViewModel*) viewModel {
    if (!_viewModel) {
        _viewModel = [WeatherViewModel new];
        _viewModel.delegate = self;
    }
    return _viewModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainView];
    [self.viewModel loadWeatherFromWeb];
}

#pragma mark - View Model Delegate

-(void)modelWasUpdated {
    [self.mainView updateView];
}




@end
