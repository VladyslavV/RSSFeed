//
//  WeatherMainView.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/19/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherViewModel.h"

@interface WeatherMainView : UIView

@property (strong, nonatomic) WeatherViewModel* viewModel;

-(void) updateView;

@end
