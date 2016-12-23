//
//  FooterButtonCollectionReusableView.m
//  HorizontaLayout
//
//  Created by guopengwen on 16/12/22.
//  Copyright © 2016年 guopengwen. All rights reserved.
//

#import "FooterButtonCollectionReusableView.h"

#define GPWScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation FooterButtonCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        [self modifySubViews];
    }
    return self;
}

- (void)modifySubViews
{
    [self addSubview:self.showLabel];
    _showLabel.frame = CGRectMake(14, 4, GPWScreenWidth - 28, 36);
    _showLabel.backgroundColor = [UIColor whiteColor];
}

- (void)updateTextOfShowLabel:(NSString *)str
{
    _showLabel.text = str;
}

- (UILabel *)showLabel{
    if (!_showLabel) {
        _showLabel = [[UILabel alloc] init];
        _showLabel.font = [UIFont systemFontOfSize:16];
        _showLabel.textColor = [UIColor colorWithRed:74/255. green:74/255. blue:74/255. alpha:1];
        
    }
    return _showLabel;
}

@end
