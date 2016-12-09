//
//  CustomCellTableViewCell.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/7/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "Masonry.h"

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
    
    self.descriptionLabel.backgroundColor = [UIColor greenColor];
    self.titleLabel.backgroundColor = [UIColor redColor];

    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(4);
        make.leading.equalTo(self.mas_leading).with.offset(4);
        make.trailing.equalTo(self.mas_trailing).with.offset(-4);
        make.bottom.equalTo(self.mas_centerY).with.offset(-4);
    }];
    
    [self.descriptionLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(4);
        make.bottom.equalTo(self.mas_bottom).with.offset(-4);
        make.leading.equalTo(self.mas_leading).with.offset(4);
        make.trailing.equalTo(self.mas_trailing).with.offset(-4);
    }];
}


@end















