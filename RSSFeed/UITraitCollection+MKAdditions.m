//
//  UITraitCollection+MKAdditions.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/12/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "UITraitCollection+MKAdditions.h"

@implementation UITraitCollection (MKAdditions)

- (BOOL)mk_matchesPhoneLandscape
{
    if (self.horizontalSizeClass == UIUserInterfaceSizeClassCompact && self.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
        return YES;
    }
    else if (self.horizontalSizeClass == UIUserInterfaceSizeClassRegular && self.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
        return YES;
    }
    else {
        return NO;
    }
}

- (BOOL)mk_matchesPhonePortrait
{
    if (self.horizontalSizeClass == UIUserInterfaceSizeClassCompact && self.verticalSizeClass == UIUserInterfaceSizeClassRegular) {
        return YES;
    }
    else {
        return NO;
    }
}

@end
