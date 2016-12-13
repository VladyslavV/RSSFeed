//
//  FeedViewDetailMainView.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/12/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedViewDetailMainView : UIView

@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UILabel* newsDescriptionLabel;
@property (strong, nonatomic) UILabel* pubDateLabel;
@property (strong, nonatomic) UIImageView* newsImageView;
@property (strong, nonatomic) UIBarButtonItem* barButtonOpenInSafari;

- (void)toggleConstraintsForTraitCollection:(UITraitCollection *)traitCollection;

-(NSAttributedString*) getAttributedString:(NSString*) oldString;

@end
