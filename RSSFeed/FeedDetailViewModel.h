//
//  FeedDetailViewlModel.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/9/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsItem.h"

@interface FeedDetailViewModel : NSObject

@property (nonatomic, strong) NewsItem* newsItem;

- (instancetype)initWithItem:(NewsItem*) newsItem;

-(NSString*) titleText;
-(NSString*) newsDescriptionText;

@end
