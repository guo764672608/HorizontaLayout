//
//  HeaderButtonCollectionReusableView.m
//  CodeKitPackageGroup
//
//  Created by guopengwen on 16/12/20.
//  Copyright © 2016年 guo. All rights reserved.
//

#import "HeaderButtonCollectionReusableView.h"

#define GPWScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation HeaderButtonCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        [self modifySubViews];
    }
    return self;
}

- (void)modifySubViews
{
    [self addSubview:self.leftLabel];
    _leftLabel.frame = CGRectMake(14, 4, GPWScreenWidth - 28, 36);
    _leftLabel.backgroundColor = [UIColor whiteColor];
}

- (void)updateTextOfLeftLabel:(NSString *)str
{
    _leftLabel.text = str;
}

- (UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.font = [UIFont systemFontOfSize:16];
        _leftLabel.textColor = [UIColor colorWithRed:74/255. green:74/255. blue:74/255. alpha:1];
                                
    }
    return _leftLabel;
}


@end
