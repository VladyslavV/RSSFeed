//
//  CustomCellTableViewCell.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/7/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface CustomTableViewCell ()


@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UILabel* descriptionLabel;

@end

@implementation CustomTableViewCell

-(UILabel*) titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        [_titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        _titleLabel.text = @"Title";
    }
    return _titleLabel;
}

-(UILabel*) descriptionLabel {
    if (_descriptionLabel == nil) {
        _descriptionLabel = [UILabel new];
        [_descriptionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        _descriptionLabel.text = @"Description";
    }
    return _descriptionLabel;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpCell];
    }
    return self;
}

-(void) setUpCell {
    self.separatorInset = UIEdgeInsetsZero;
    [self addSubview:self.titleLabel];
    [self addSubview:self.descriptionLabel];
    
    NSDictionary *elementsDict = NSDictionaryOfVariableBindings(_titleLabel, _descriptionLabel);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-4-[_titleLabel]-4-[_descriptionLabel]-4-|"
                                                                options:NSLayoutFormatDirectionLeadingToTrailing
                                                                metrics:nil
                                                                  views:elementsDict]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLabel]-|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:elementsDict]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_descriptionLabel]-|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:elementsDict]];
}


@end















