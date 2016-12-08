//
//  FeedViewModel.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/8/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AllNews.h"
#import "FeedView.h"

@interface FeedViewModel : NSObject 

-(void) updateModel;

@property (weak, nonatomic) FeedView* feedView;

@end

