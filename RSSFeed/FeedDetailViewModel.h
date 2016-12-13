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

@property (nonatomic, strong) NewsItem* newsItem;

- (instancetype)initWithItem:(NewsItem*) newsItem;

-(NSString*) titleText;
-(NSString*) pubDateText;
-(NSString*) newsDescriptionText;
-(NSString*) imageURL;
-(NSURL*) newsLink;

//fetch image with URL
-(void) fetchImageWithUrl:(NSString*) imgageUrl andCallBack:( void (^)(NSData* imageData)) completion;


@end
