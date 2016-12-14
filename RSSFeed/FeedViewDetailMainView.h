//
//  FeedViewDetailMainView.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/12/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedDetailViewModel.h"

@protocol FeedViewDetailMainViewDelegate <NSObject>

-(void) imageTapped;

@end

@interface FeedViewDetailMainView : UIView 

@property(weak, nonatomic) id <FeedViewDetailMainViewDelegate> delegate;

@property (strong, nonatomic) UIBarButtonItem* barButtonOpenInSafari;

@property (strong, nonatomic) UIImageView* newsImageView;

- (void)toggleConstraintsForTraitCollection:(UITraitCollection *)traitCollection;

-(NSAttributedString*) getAttributedString:(NSString*) oldString;

- (instancetype)initWithModel:(FeedDetailViewModel*) model;

-(void) addBlurView;
-(void) removeBlurView;

@end
