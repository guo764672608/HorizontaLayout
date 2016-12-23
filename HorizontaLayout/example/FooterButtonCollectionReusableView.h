//
//  FooterButtonCollectionReusableView.h
//  HorizontaLayout
//
//  Created by guopengwen on 16/12/22.
//  Copyright © 2016年 guopengwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FooterButtonCollectionReusableView : UICollectionReusableView

@property (nonatomic, strong) UILabel *showLabel;

- (void)updateTextOfShowLabel:(NSString *)str;

@end
