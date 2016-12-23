//
//  GPWButtonCollectionViewCell.h
//  CodeKitPackageGroup
//
//  Created by guopengwen on 16/12/18.
//  Copyright © 2016年 guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GPWButtonCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *desLabel;

- (void)updateDescriptionLabel:(NSString *)des;

@end
