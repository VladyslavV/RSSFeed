//
//  Fetcher.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/6/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AllNews.h"

@protocol FetcherDelegate <NSObject>

-(void) allNewsParsed:(AllNews*) allNews;

@end

@interface Fetcher : NSObject

@property (nonatomic, weak) id <FetcherDelegate> delegate;


//fetch data
-(void) fetchData;

@end
