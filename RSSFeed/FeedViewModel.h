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
#import "FeedDetailViewModel.h"

@protocol FeedViewModelDelegate <NSObject>

-(void) modelWasUpdated;

@end

@interface FeedViewModel : NSObject <UITableViewDataSource>


//delegate
@property (nonatomic, weak) id <FeedViewModelDelegate> delegate;

// work with model
-(void) loadModelFromWeb;
-(void) loadModelFromCoreData;
-(void) filterTableWithString:(NSString*) searchString withCompletion:(void (^)(void)) completed;

-(NSString*) searchBarPlaceholder;

// detail view model
-(FeedDetailViewModel*) createFeedDetailViewModelForCell:(NSInteger) cellIndex;


@end

