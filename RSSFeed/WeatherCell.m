//
//  WeatherCell.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/20/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "WeatherCell.h"

@interface WeatherCell ()

@end

@implementation WeatherCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_cityLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
}


@end
