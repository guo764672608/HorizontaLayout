//
//  ShowButtonViewController.m
//  CodeKitPackageGroup
//
//  Created by guopengwen on 16/12/18.
//  Copyright © 2016年 guo. All rights reserved.
//

#import "ShowButtonViewController.h"
#import "GPWButtonCollectionViewCell.h"
#import "HorizontalDistributeLayout.h"
#import "HeaderButtonCollectionReusableView.h"
#import "FooterButtonCollectionReusableView.h"

#define ReuseItemIdentifier @"GPWButtonCollectionViewCell"
#define ReuseHeaderIdentifier @"GPWHeaderButtonCollectionReusableView"
#define ReuseFooterIdentifier @"GPWFooterButtonCollectionReusableView"


@interface ShowButtonViewController ()<UICollectionViewDataSource,HorizontalDistributeLayoutDelegate>

@property (strong, nonatomic) UICollectionView *buttonsView;

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSArray *headerArr;
@property (nonatomic, strong) NSArray *footerArr;
@end

@implementation ShowButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initDataForButton];
    [self createButtonCollectionView];
   
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = _dataArr[indexPath.section];
    //return [self calculatelabelSizeForStr:arr[indexPath.item]];
    NSString *str = arr[indexPath.item];
    return CGSizeMake(20 + str.length * 14, 30);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section
{
    return 44;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = _dataArr[indexPath.section];
    NSLog(@"ccollectionView--buttonTitle=%@",arr[indexPath.item]);
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.headerArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *arr = self.dataArr[section];
    return arr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GPWButtonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ReuseItemIdentifier forIndexPath:indexPath];
    NSArray *arr = _dataArr[indexPath.section];
    [cell updateDescriptionLabel:arr[indexPath.item]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:GPWCollectionElementKindSectionHeader]) {
        HeaderButtonCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:GPWCollectionElementKindSectionHeader withReuseIdentifier:ReuseHeaderIdentifier forIndexPath:indexPath];
        [headerView updateTextOfLeftLabel: _headerArr[indexPath.section]];
        return headerView;
    } else {
        FooterButtonCollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:GPWCollectionElementKindSectionFooter withReuseIdentifier:ReuseFooterIdentifier forIndexPath:indexPath];
        [footerView updateTextOfShowLabel: _footerArr[indexPath.section]];
        return footerView;
    }
}

#pragma mark -- private

- (void)createButtonCollectionView{
    HorizontalDistributeLayout  *layout = [[HorizontalDistributeLayout alloc] init];
    layout.minimumInteritemSpacing = 20;
    layout.minimumLineSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(25, 25, 25, 25);
    
    self.buttonsView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _buttonsView.backgroundColor = [UIColor whiteColor];
    _buttonsView.delegate = self;
    _buttonsView.dataSource = self;
    _buttonsView.bounces = NO;
    [_buttonsView registerClass:[GPWButtonCollectionViewCell class] forCellWithReuseIdentifier:ReuseItemIdentifier];
    [_buttonsView registerClass:[HeaderButtonCollectionReusableView class] forSupplementaryViewOfKind:GPWCollectionElementKindSectionHeader withReuseIdentifier:ReuseHeaderIdentifier];
    [_buttonsView registerClass:[FooterButtonCollectionReusableView class] forSupplementaryViewOfKind:GPWCollectionElementKindSectionFooter withReuseIdentifier:ReuseFooterIdentifier];
    [self.view addSubview:_buttonsView];
    
}

- (void)initDataForButton{
    self.headerArr = @[@"历史搜索", @"热门搜索"];
    self.dataArr = [NSMutableArray array];
    NSArray *arr1 = @[@"车型", @"新款"];
    NSArray *arr2 = @[@"车型", @"新款",@"历史搜索", @"热门", @"搜索",@"车型", @"新款",@"历史@", @"搜索", @"热门搜索",@"车型搜索", @"新款",@"历史搜索", @"热门搜索"];
    [_dataArr addObject:arr1];
    [_dataArr addObject:arr2];
    self.footerArr = @[@"感谢关注,请不要吝啬你的宝贵意见！", @"欢迎使用，请监督我们的更新维护服务！"];
}

- (CGSize)calculatelabelSizeForStr:(NSString *)str
{
    CGSize titleSize = [str boundingRectWithSize:CGSizeMake(200, 18) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    return titleSize;
}

@end
