//
//  OtherCell.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/6/7.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "OtherCell.h"
#import "FirstItem.h"
#import "SecondCollectionCell.h"

CGFloat const kMargin = 15;

static NSString * const kSecondCell = @"secondCell";

@interface OtherCell () <UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation OtherCell


- (UICollectionViewFlowLayout *)layout
{
    if (!_layout) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(70, 100);
        layout.minimumLineSpacing = 20;
        _layout = layout;
    }
    return _layout;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.collectionView.collectionViewLayout = self.layout;
    [self.collectionView registerNib:[UINib nibWithNibName:@"SecondCollectionCell" bundle:nil] forCellWithReuseIdentifier:kSecondCell];
    self.collectionView.dataSource = self;
    self.collectionView.contentInset = UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin);
    self.collectionView.scrollEnabled = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
  
}

- (void)setChannel:(Channel *)channel
{
    _channel = channel;
    self.titleLabel.text = channel.name;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.channel.channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SecondCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSecondCell forIndexPath:indexPath];
    SecondItem *item = self.channel.channels[indexPath.row];
    cell.item = item;
    
    return cell;
}

@end
