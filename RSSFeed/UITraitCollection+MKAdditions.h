//
//  UITraitCollection+MKAdditions.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/12/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITraitCollection (MKAdditions)

// Any iphone in landscape orientation
- (BOOL)mk_matchesPhoneLandscape;

// Any iphone in portrait orientation
- (BOOL)mk_matchesPhonePortrait;

@end

