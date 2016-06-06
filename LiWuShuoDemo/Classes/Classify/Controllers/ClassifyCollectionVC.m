//
//  ClassifyCollectionVC.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/22.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "ClassifyCollectionVC.h"
#import "FristCell.h"
#import "SecondCell.h"
#import "ClassifyRequest.h"
#import "FirstItem.h"
#import "MJExtension.h"

static NSString * const firstCell = @"firstCell";
static NSString * const secondCell = @"secondCell";
static CGFloat const kMargin = 15;

@interface ClassifyCollectionVC ()

@property (nonatomic, strong) NSArray *channelGroups;
@property (nonatomic, strong) NSArray *collections;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation ClassifyCollectionVC

- (NSArray *)channelGroups
{
    if (!_channelGroups) {
        _channelGroups = [NSArray array];
    }
    return _channelGroups;
}

- (UICollectionViewFlowLayout *)layout
{
    if (!_layout) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(70, 100);
        layout.minimumLineSpacing = 20;
//        layout.minimumInteritemSpacing = 25;
    
        _layout = layout;
    }
    return _layout;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataBack];
    [self settingForColletionView];
}

- (void)settingForColletionView
{
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.collectionViewLayout = self.layout;
    [self.collectionView registerClass:[FristCell class] forCellWithReuseIdentifier:firstCell];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SecondCell" bundle:nil] forCellWithReuseIdentifier:secondCell];
    self.collectionView.contentInset = UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin);
}

- (void)getDataBack
{
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_enter(group);
    
    ChannelsRequest *firstRequest = [[ChannelsRequest alloc] init];
    [firstRequest starWithFinishedBlock:^(NSError *error, id result) {
        if (!error) {
            self.channelGroups = [Channel mj_objectArrayWithKeyValuesArray:[result[@"data"] objectForKey:@"channel_groups"]];

            [self.collectionView reloadData];
        }
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return self.channelGroups.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    Channel *channel = self.channelGroups[section];
    return channel.channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SecondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:secondCell forIndexPath:indexPath];
    
    Channel *channel = self.channelGroups[indexPath.section];
    SecondItem *item = channel.channels[indexPath.row];
    cell.item = item;
    
    return cell;
}




@end
