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

@interface WeatherVC ()

@property (strong, nonatomic) WeatherMainView* mainView;

@property (strong, nonatomic) WeatherViewModel* viewModel;

@end

@implementation WeatherVC

#pragma mark - Create

-(WeatherMainView*) mainView {
    if (!_mainView) {
        _mainView = [WeatherMainView new];
        _mainView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _mainView;
}

-(WeatherViewModel*) viewModel {
    if (!_viewModel) {
        _viewModel = [WeatherViewModel new];
    }
    return _viewModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self.view addSubview:self.mainView];
    
    [self.viewModel loadWeatherFromWeb];
    
    self.view.backgroundColor = [UIColor yellowColor];
}




@end
