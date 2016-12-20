//
//  Weather.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/20/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <MTLModel.h>
#import "Mantle.h"

@interface Weather : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic) NSString* condition;
@property (copy, nonatomic) NSString* detailed;
@property (copy, nonatomic) NSString* icon;

@property (nonatomic) float  theID;

@end
