//
//  HeaderButtonCollectionReusableView.h
//  CodeKitPackageGroup
//
//  Created by guopengwen on 16/12/20.
//  Copyright © 2016年 guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderButtonCollectionReusableView : UICollectionReusableView

@property (nonatomic, strong) UILabel *leftLabel;

- (void)updateTextOfLeftLabel:(NSString *)str;

@end
