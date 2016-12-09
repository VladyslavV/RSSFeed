//
//  FeedViewModel.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/8/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AllNews.h"
#import <UIKit/UIKit.h>

@protocol FeedViewModelDelegate <NSObject>

-(void) modelWasUpdated;

@end

@interface FeedViewModel : NSObject <UITableViewDataSource>

@property (nonatomic, weak) id <FeedViewModelDelegate> delegate;

-(void) updateModel;

@end

