//
//  FeedView.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/7/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedViewModel.h"

@interface FeedView : UIView

-(void) update;

@property(strong, nonatomic) FeedViewModel* feedViewModel;

@end
