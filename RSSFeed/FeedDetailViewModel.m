//
//  FeedDetailViewlModel.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/9/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "FeedDetailViewModel.h"

@interface FeedDetailViewModel()

@property NSArray *iPadPortraitConstraints;
@property NSArray *phonePortraitConstraints;
@property NSArray *phoneLandscapeConstraints;

@property (nonatomic, strong) NewsItem* newsItem;

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

-(NSString*) pubDateText {
    return self.newsItem.pubDate;
}

-(NSURL*) imageURL {
    return [NSURL URLWithString: self.newsItem.imageURL];
}

-(NSURL*) newsLink {
    return [NSURL URLWithString:self.newsItem.newsLink];
}

-(NSString*) openInBrowserString {
    return NSLocalizedString(@"navigation.bar.openinbrowser", nil);
}

@end
