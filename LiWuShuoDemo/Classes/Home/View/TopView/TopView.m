//
//  TopView.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/26.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "TopView.h"
#import "BannerView.h"
#import "UIView+FrameExtension.h"
#import "Banner.h"
#import "UIImageView+WebCache.h"

static NSString * const kBannerCellId = @"kBannerCellId";

@interface TopView ()<UICollectionViewDelegate, UICollectionViewDataSource>


@property (nonatomic, weak)   UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation TopView

- (UICollectionViewFlowLayout *)layout
{
    if (!_layout) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(95, 95);
        layout.minimumLineSpacing = 10;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout = layout;
    }
    return _layout;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bannerView.frame), self.width, 115) collectionViewLayout:self.layout];
        collectionView.pagingEnabled = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
        [collectionView registerClass:[SecondBannerCell class] forCellWithReuseIdentifier:kBannerCellId];
        [self addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (BannerView *)bannerView
{
    if (!_bannerView) {
        BannerView *banner = [[BannerView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width / 2.5)];
        [self addSubview:banner];
        _bannerView = banner;
    }
    return _bannerView;
}

- (void)setSecondBanners:(NSArray *)secondBanners
{
    _secondBanners = secondBanners;
    [self.collectionView reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
      
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.secondBanners.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SecondBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBannerCellId forIndexPath:indexPath];
    SecondBanner *banner = self.secondBanners[indexPath.row];
    cell.banner = banner;
    return cell;
}

@end



@interface SecondBannerCell ()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation SecondBannerCell

- (UIImageView *)imageView
{
    if (!_imageView) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.frame = self.bounds;
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        [self addSubview:imageV];
        _imageView = imageV;
    }
    return _imageView;
}

- (void)setBanner:(SecondBanner *)banner
{
    _banner = banner;
    [self.imageView sd_setImageWithURL:banner.image_url placeholderImage:[UIImage imageNamed:@"placeholderimage_small"]];
}



@end


