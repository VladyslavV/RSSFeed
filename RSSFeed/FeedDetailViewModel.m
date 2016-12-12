//
//  FeedDetailViewlModel.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/9/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "FeedDetailViewModel.h"

@interface FeedDetailViewModel()

@end

@implementation FeedDetailViewModel

- (instancetype)initWithItem:(NewsItem*) newsItem
{
    self = [super init];
    if (self) {
        _newsItem = newsItem;
    }
    return self;
}
-(NSString*) titleText {
    return self.newsItem.title;
}


-(NSString*) newsDescriptionText {
    return self.newsItem.newsDescription;
}




@end
