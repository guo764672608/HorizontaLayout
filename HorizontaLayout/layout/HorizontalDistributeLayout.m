//
//  HorizontalDistributeLayout.m
//  HorizontaLayout
//
//  Created by guopengwen on 16/12/21.
//  Copyright © 2016年 guopengwen. All rights reserved.
//

#import "HorizontalDistributeLayout.h"


NSString *const GPWCollectionElementKindSectionHeader = @"GPWCollectionElementKindSectionHeader";

NSString *const GPWCollectionElementKindSectionFooter = @"GPWCollectionElementKindSectionFooter";

@interface HorizontalDistributeLayout ()

@property (nonatomic, weak) id<HorizontalDistributeLayoutDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *sectionItemAttributes;

@property (nonatomic, strong) NSMutableArray *allItemAttributes;

@property (nonatomic, strong) NSMutableArray *itemFrame;

@property (nonatomic, strong) NSMutableDictionary *headersAttribute;

@property (nonatomic, strong) NSMutableDictionary *footersAttribute;

@property (nonatomic, assign) CGFloat viewHeight;

@end


@implementation HorizontalDistributeLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

// 必须实现的三个方法
- (void)prepareLayout
{
    [super prepareLayout];
    
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    if (numberOfSections == 0) {
        return;
    }
    
    [self.headersAttribute removeAllObjects];
    [self.allItemAttributes removeAllObjects];
    [self.sectionItemAttributes removeAllObjects];
    
    // Create attributes
    CGFloat top = 0;
    CGFloat rowWidth = 0;
    _viewHeight = 0;
    UICollectionViewLayoutAttributes *attributes;
    // collectionView 的宽
    CGFloat width = self.collectionView.frame.size.width;
    
    for (NSInteger section = 0; section < numberOfSections; ++section){
        
        UIEdgeInsets sectionInset;
        if ([self.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
            sectionInset = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
        } else {
            sectionInset = self.sectionInset;
        }
        
        CGFloat minimumInteritemSpacing;
        if ([self.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
            minimumInteritemSpacing = [self.delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:section];
        } else {
            minimumInteritemSpacing = self.minimumInteritemSpacing;
        }
        
        // 分区头
        CGFloat headerHeight;
        if ([self.delegate respondsToSelector:@selector(collectionView:layout:heightForHeaderInSection:)]) {
            headerHeight = [self.delegate collectionView:self.collectionView layout:self heightForHeaderInSection:section];
        } else {
            headerHeight = self.headerHeight;
        }
        
        if (headerHeight > 0) {
            attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:GPWCollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
            attributes.frame = CGRectMake(0,_viewHeight,width, headerHeight);
            self.headersAttribute[@(section)] = attributes;
            [self.allItemAttributes addObject:attributes];
        }
        _viewHeight = CGRectGetMaxY(attributes.frame);
        
        // 每个item的属性
        rowWidth = sectionInset.left;
        _viewHeight += sectionInset.top;
        top = _viewHeight;
        
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        NSMutableArray *itemAttributes = [NSMutableArray arrayWithCapacity:itemCount];
        for (NSInteger item = 0; item < itemCount ; item++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            CGFloat itemWidth = 0;
            CGFloat itemHeight = 0;
            if ([self.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
                CGSize size = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
                itemWidth = size.width;
                itemHeight = size.height;
                if (top + itemHeight >= _viewHeight) {
                    _viewHeight = top + itemHeight;
                }
            }
            
            if (rowWidth + itemWidth > width - sectionInset.right) {
                rowWidth = sectionInset.left;
                top = _viewHeight + _minimumLineSpacing;
            }
            
            attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attributes.frame = CGRectMake(rowWidth, top, itemWidth, itemHeight);
            [itemAttributes addObject:attributes];
            [self.allItemAttributes addObject:attributes];
            rowWidth += itemWidth + minimumInteritemSpacing;
            _viewHeight = CGRectGetMaxY(attributes.frame);
        }
        [self.sectionItemAttributes addObject:itemAttributes];
        
        _viewHeight += sectionInset.bottom;
        CGFloat footerHeight;
        if ([self.delegate respondsToSelector:@selector(collectionView:layout:heightForFooterInSection:)]) {
            footerHeight = [self.delegate collectionView:self.collectionView layout:self heightForFooterInSection:section];
        } else {
            footerHeight = self.footerHeight;
        }
        
        if (footerHeight > 0) {
            attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:GPWCollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
            attributes.frame = CGRectMake(0, _viewHeight,
                                          width,
                                          footerHeight);
            
            self.footersAttribute[@(section)] = attributes;
            [self.allItemAttributes addObject:attributes];
            _viewHeight = CGRectGetMaxY(attributes.frame);
        }
        
    }
    
    NSInteger idx = 0;
    NSInteger itemCounts = [self.allItemAttributes count];
    while (idx < itemCounts) {
        CGRect rect = ((UICollectionViewLayoutAttributes *)self.allItemAttributes[idx]).frame;
        [self.itemFrame addObject:[NSValue valueWithCGRect:rect]];
        idx++;
    }
}

- (CGSize)collectionViewContentSize {
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    if (numberOfSections == 0) {
        return CGSizeZero;
    }
    
    CGSize contentSize = self.collectionView.bounds.size;
    contentSize.height = _viewHeight;
    
    return contentSize;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path {
    if (path.section >= [self.sectionItemAttributes count]) {
        return nil;
    }
    if (path.item >= [self.sectionItemAttributes[path.section] count]) {
        return nil;
    }
    return (self.sectionItemAttributes[path.section])[path.item];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attribute = nil;
    if ([kind isEqualToString:GPWCollectionElementKindSectionHeader]) {
        attribute = self.headersAttribute[@(indexPath.section)];
    } else if ([kind isEqualToString:GPWCollectionElementKindSectionFooter]) {
        attribute = self.footersAttribute[@(indexPath.section)];
    }
    return attribute;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSInteger i;
    NSInteger begin = 0, end = self.itemFrame.count;
    NSMutableArray *attrs = [NSMutableArray array];
    
    for (i = 0; i < self.itemFrame.count; i++) {
        if (CGRectIntersectsRect(rect, [self.itemFrame[i] CGRectValue])) {
            begin = i;
            break;
        }
    }
    for (i = self.itemFrame.count - 1; i >= 0; i--) {
        if (CGRectIntersectsRect(rect, [self.itemFrame[i] CGRectValue])) {
            end = self.allItemAttributes.count;
            break;
        }
    }
    for (i = begin; i < end; i++) {
        UICollectionViewLayoutAttributes *attr = self.allItemAttributes[i];
        if (CGRectIntersectsRect(rect, attr.frame)) {
            [attrs addObject:attr];
        }
    }
    
    return [NSArray arrayWithArray:attrs];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    return NO;
}

- (void)commonInit
{
    _minimumLineSpacing = 10;
    _minimumInteritemSpacing = 10;
    _headerHeight = 0;
    _footerHeight = 0;
}

#pragma mark - Public Accessors
- (void)setMinimumLineSpacing:(CGFloat)minimumLineSpacing {
    if (_minimumLineSpacing != minimumLineSpacing) {
        _minimumLineSpacing = minimumLineSpacing;
        [self invalidateLayout];
    }
}

- (void)setMinimumInteritemSpacing:(CGFloat)minimumInteritemSpacing {
    if (_minimumInteritemSpacing != minimumInteritemSpacing) {
        _minimumInteritemSpacing = minimumInteritemSpacing;
        [self invalidateLayout];
    }
}

- (void)setHeaderHeight:(CGFloat)headerHeight {
    if (_headerHeight != headerHeight) {
        _headerHeight = headerHeight;
        [self invalidateLayout];
    }
}

- (void)setFooterHeight:(CGFloat)footerHeight {
    if (_footerHeight != footerHeight) {
        _footerHeight = footerHeight;
        [self invalidateLayout];
    }
}

- (void)setSectionInset:(UIEdgeInsets)sectionInset {
    if (!UIEdgeInsetsEqualToEdgeInsets(_sectionInset, sectionInset)) {
        _sectionInset = sectionInset;
        [self invalidateLayout];
    }
}


#pragma mark - setter and getter

- (id<HorizontalDistributeLayoutDelegate>)delegate {
    return (id<HorizontalDistributeLayoutDelegate>)self.collectionView.delegate;
}

- (NSMutableDictionary *)headersAttribute{
    if (!_headersAttribute) {
        _headersAttribute = [NSMutableDictionary dictionary];
    }
    return _headersAttribute;
}

- (NSMutableDictionary *)footersAttribute{
    if (!_footersAttribute) {
        _footersAttribute = [NSMutableDictionary dictionary];
    }
    return _footersAttribute;
}

- (NSMutableArray *)allItemAttributes{
    if (!_allItemAttributes) {
        _allItemAttributes = [NSMutableArray array];
    }
    return _allItemAttributes;
}

- (NSMutableArray *)sectionItemAttributes {
    if (!_sectionItemAttributes) {
        _sectionItemAttributes = [NSMutableArray array];
    }
    return _sectionItemAttributes;
}

- (NSMutableArray *)itemFrame {
    if (!_itemFrame) {
        _itemFrame = [NSMutableArray array];
    }
    return _itemFrame;
}

@end

