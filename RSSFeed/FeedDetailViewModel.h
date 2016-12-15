//
//  FeedDetailViewlModel.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/9/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsItem.h"
#import <UIKit/UIKit.h>

@interface FeedDetailViewModel : NSObject

- (instancetype)initWithItem:(NewsItem*) newsItem;

-(NSString*) titleText;
-(NSString*) pubDateText;
-(NSString*) newsDescriptionText;
-(NSURL*) imageURL;
-(NSURL*) newsLink;

-(NSString*) openInBrowserString;

@end
