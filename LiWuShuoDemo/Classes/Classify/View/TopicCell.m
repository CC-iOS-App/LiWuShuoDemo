//
//  TopicCell.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/6/6.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "TopicCell.h"
#import "FirstItem.h"
#import "UIImageView+WebCache.h"

static CGFloat const kTopicMargin = 10;
static NSString * const kFirstItemCell = @"kFirstItemCell";

@interface TopicCell () <UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *viewMoreBtn;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation TopicCell

- (UICollectionViewFlowLayout *)layout
{
    if (!_layout) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(150, 75);
        layout.minimumInteritemSpacing = 10;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout = layout;
    }
    return _layout;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.collectionView.collectionViewLayout = self.layout;
    [self.collectionView registerClass:[TopCollectionCell class] forCellWithReuseIdentifier:kFirstItemCell];
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(kTopicMargin, kTopicMargin, kTopicMargin, kTopicMargin);
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

- (void)setFirstItems:(NSArray *)firstItems
{
    _firstItems = firstItems;
    [self.collectionView reloadData];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.firstItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TopCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kFirstItemCell forIndexPath:indexPath];
    
    FirstItem *item = self.firstItems[indexPath.row];
    cell.item = item;
    
    return cell;
}

@end




@interface TopCollectionCell ()

@property (nonatomic, strong) UIImageView *imageV;

@end


@implementation TopCollectionCell

- (UIImageView *)imageV
{
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        _imageV.frame = self.bounds;
        _imageV.layer.cornerRadius = 3;
        _imageV.layer.masksToBounds = YES;
        [self.contentView addSubview:_imageV];
    }
    return _imageV;
}

- (void)setItem:(FirstItem *)item
{
    _item = item;
    [self.imageV sd_setImageWithURL:item.banner_image_url];
}



@end