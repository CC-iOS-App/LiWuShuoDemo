//
//  HomeCollectionVC.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/22.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "BaseCollectionVC.h"
#import "UIImage+Extension.h"
#import "UIColor+CustomColor.h"
#import "HomeCell.h"
#import "HandPickrequest.h"
#import "MJExtension.h"
#import "Item.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "HomeDetailVC.h"

static CGFloat const kMargin     = 10;
static CGFloat const kItemHeight = 160;

@interface BaseCollectionVC ()

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic ,strong) NSArray *refreshImages;

@end

@implementation BaseCollectionVC

static NSString * const kReuseIdentifier = @"Cell";

- (NSArray *)refreshImages
{
    if (!_refreshImages) {
        _refreshImages = @[[UIImage imageNamed:@"box_01"],[UIImage imageNamed:@"box_02"],[UIImage imageNamed:@"box_03"],[UIImage imageNamed:@"box_04"],[UIImage imageNamed:@"box_05"],[UIImage imageNamed:@"heart"],[UIImage imageNamed:@"box_05"],[UIImage imageNamed:@"box_04"],[UIImage imageNamed:@"box_03"],[UIImage imageNamed:@"box_02"],[UIImage imageNamed:@"box_01"]];
    }
    return _refreshImages;
}

- (void)setRefreshHeaderFooter
{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    [header setImages:@[[UIImage imageNamed:@"box_01"]] forState:MJRefreshStateIdle];
    [header setImages:@[[UIImage imageNamed:@"box_01"]] forState:MJRefreshStatePulling];
    [header setImages:self.refreshImages forState:MJRefreshStateRefreshing];
    self.collectionView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.collectionView.mj_footer = footer;
}

- (NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    [self SetUpCollectionView];
    [self setRefreshHeaderFooter];

    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellWithReuseIdentifier:kReuseIdentifier];
    
    [self loadNewData];
    
    // Do any additional setup after loading the view.
}

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * kMargin, kItemHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = kMargin;
    
    return [super initWithCollectionViewLayout:layout];
}

- (void)SetUpCollectionView
{
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.contentInset = UIEdgeInsetsMake(kMargin, 0, 0, 0);
    self.collectionView.backgroundColor = [UIColor collectionBackgroundColor];
    
}

- (void)loadNewData
{
    
    [self.baseRequest starWithFinishedBlock:^(NSError *error, id result) {
        NSLog(@"error is:%@",error);
        if (!error) {
            [self.collectionView.mj_header endRefreshing];
            self.items = [Item mj_objectArrayWithKeyValuesArray:[result[@"data"] objectForKey:@"items"]];
            [self.collectionView reloadData];
        }
    }];
}

- (void)loadMoreData
{
    [self.loadMoreRequest starWithFinishedBlock:^(NSError *error, id result) {
        if (!error) {
            [self.collectionView.mj_footer endRefreshing];
            [self.items addObjectsFromArray:[Item mj_objectArrayWithKeyValuesArray:[result[@"data"] objectForKey:@"items"]]];
            [self.collectionView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseIdentifier forIndexPath:indexPath];
    if (![self.title isEqualToString:@"精选"]) {
        [cell.tagNewImageView setHidden:YES];
    }
    Item * item = self.items[indexPath.row];
    cell.item = item;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    Item *item = self.items[indexPath.row];
    HomeDetailVC *vc = [[HomeDetailVC alloc] init];
    vc.itemId = item.itemId;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

@end
