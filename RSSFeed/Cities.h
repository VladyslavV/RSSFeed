//
//  Cities.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/20/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "Mantle.h"
#import "MTLModel.h"
#import "City.h"

@interface Cities : MTLModel <MTLJSONSerializing>

@property (nonatomic) NSArray* array;


@end
