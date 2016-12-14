//
//  FeedViewDetailVC.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/9/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedDetailViewModel.h"
#import "FeedViewDetailMainView.h"

@interface FeedViewDetailVC : UIViewController <FeedViewDetailMainViewDelegate, UIPopoverPresentationControllerDelegate>

- (instancetype)initWithViewModel:(FeedDetailViewModel*) feedDetailViewModel;

@end
