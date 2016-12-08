//
//  AllNews.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/6/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsItem.h"

@interface AllNews : NSObject

@property (nonatomic, strong, readonly) NSMutableArray* data;

-(void) addItem:(NSMutableDictionary*) newItemDict;

@end
