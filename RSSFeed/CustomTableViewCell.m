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

@end

@implementation CustomTableViewCell

-(UILabel*) numberLabel {
    if (_numberLabel == nil) {
        _numberLabel = [UILabel new];
        [_numberLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_numberLabel sizeToFit];
        [_numberLabel setFont:[UIFont systemFontOfSize:14]];
        _numberLabel.adjustsFontSizeToFitWidth = YES;
        _numberLabel.numberOfLines = 0;
    }
    return _numberLabel;
}


-(UILabel*) titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        [_titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_titleLabel setFont:[UIFont systemFontOfSize:18]];
        _titleLabel.text = @"Title";
    }
    return _titleLabel;
}

-(UILabel*) descriptionLabel {
    if (_descriptionLabel == nil) {
        _descriptionLabel = [UILabel new];
        [_descriptionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_descriptionLabel setFont:[UIFont systemFontOfSize:12]];
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
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.separatorInset = UIEdgeInsetsZero;
    [self addSubview:self.titleLabel];
    [self addSubview:self.descriptionLabel];
    [self addSubview:self.numberLabel];
    
    self.backgroundColor = [UIColor clearColor];
    self.titleLabel.backgroundColor = [UIColor greenColor];
    
    [self.numberLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_leading).with.offset(8);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(self.mas_height).multipliedBy(0.9);
        make.width.equalTo(@20);
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(4);
        make.leading.equalTo(self.numberLabel.mas_trailing).with.offset(4);
        make.trailing.equalTo(self.mas_trailing).with.offset(-4);
        make.bottom.equalTo(self.mas_centerY).with.offset(0);
    }];
    
    [self.descriptionLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(4);
        make.bottom.equalTo(self.mas_bottom).with.offset(-4);
        make.leading.equalTo(self.numberLabel.mas_trailing).with.offset(4);
        make.trailing.equalTo(self.mas_trailing).with.offset(-4);
    }];
    
    
}


@end















