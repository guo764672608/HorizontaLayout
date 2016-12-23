//
//  GPWButtonCollectionViewCell.m
//  CodeKitPackageGroup
//
//  Created by guopengwen on 16/12/18.
//  Copyright © 2016年 guo. All rights reserved.
//

#import "GPWButtonCollectionViewCell.h"

@implementation GPWButtonCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createDescriptionLabel];
    }
    return self;
}

- (void)createDescriptionLabel{
    self.desLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _desLabel.backgroundColor = [UIColor orangeColor];
    _desLabel.layer.borderWidth = 0.5;
    _desLabel.textAlignment = NSTextAlignmentCenter;
    _desLabel.layer.borderColor = [UIColor grayColor].CGColor;
    _desLabel.textColor = [UIColor darkGrayColor];
    _desLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_desLabel];
}

- (void)updateDescriptionLabel:(NSString *)des{
    _desLabel.text = des;
    NSInteger n = des.length;
    _desLabel.frame = CGRectMake(0, 0, 20 + n * 14, 30);
}



@end
