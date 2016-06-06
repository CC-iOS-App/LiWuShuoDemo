//
//  HomeCollectionVC.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/22.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "HomeCollectionVC.h"
#import "UIImage+Extension.h"
#import "UIColor+CustomColor.h"
#import "HomeCell.h"
#import "HandPickrequest.h"
#import "MJExtension.h"
#import "Item.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "Banner.h"
#import "TopCell.h"
#import "HomeDetailVC.h"

static CGFloat const kMargin     = 10;
static CGFloat const kItemHeight = 160;

static NSString * const kReuseIdentifier = @"Cell";
static NSString * const kTopCellId = @"kTopCellId";

@interface HomeCollectionVC ()

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) NSArray *banners;
@property (nonatomic, strong) NSArray *secondBanners;

@property (nonatomic ,strong) NSArray *refreshImages;

@end

@implementation HomeCollectionVC



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
    [self.collectionView registerClass:[TopCell class] forCellWithReuseIdentifier:kTopCellId];
    
    [self loadNewData];
    
    // Do any additional setup after loading the view.
}

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = kMargin;
    
    return [super initWithCollectionViewLayout:layout];
}

- (void)SetUpCollectionView
{
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView.backgroundColor = [UIColor collectionBackgroundColor];
    
}

- (void)loadNewData
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    

        HandPickrequest *request = [[HandPickrequest alloc] init];
        [request starWithFinishedBlock:^(NSError *error, id result) {
//            NSLog(@"Item error is:%@",error);
            if (!error) {
               
                self.items = [Item mj_objectArrayWithKeyValuesArray:[result[@"data"] objectForKey:@"items"]];
          
                dispatch_group_leave(group);
       
            }
        }];
    
        dispatch_group_enter(group);

        BannerRequest *bannerRequest = [[BannerRequest alloc] init];
        [bannerRequest starWithFinishedBlock:^(NSError *error, id result) {
           
            if (!error) {
               
                self.banners = [Banner mj_objectArrayWithKeyValuesArray:[result[@"data"] objectForKey:@"banners"]];
                dispatch_group_leave(group);
            
            }
        }];

        dispatch_group_enter(group);

        SecondBannerRequest *secondRequest = [[SecondBannerRequest alloc] init];
        [secondRequest starWithFinishedBlock:^(NSError *error, id result) {
//            NSLog(@"SecondBanner error is:%@",error);
            if (!error) {
                
                self.secondBanners = [SecondBanner mj_objectArrayWithKeyValuesArray:[result[@"data"] objectForKey:@"secondary_banners"]];
                dispatch_group_leave(group);
             
            }
        }];


    dispatch_group_notify(group, dispatch_get_main_queue(), ^{

         [self.collectionView.mj_header endRefreshing];
//        NSLog(@"%@===%@===%@",self.items,self.banners,self.secondBanners);
        [self.collectionView reloadData];
    });
}

- (void)loadMoreData
{
    LoadMoreRequest *request = [[LoadMoreRequest alloc] init];
    [request starWithFinishedBlock:^(NSError *error, id result) {
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
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section == 0){
        return 1;
    }else{
        return self.items.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        TopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTopCellId forIndexPath:indexPath];
        cell.banners = self.banners;
        cell.secondBanners = self.secondBanners;
        return cell;
    }else{
        HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseIdentifier forIndexPath:indexPath];
        if (![self.title isEqualToString:@"精选"]) {
            [cell.tagNewImageView setHidden:YES];
        }
        Item * item = self.items[indexPath.row];
        cell.item = item;
        
        return cell;
    }

}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath == 0) {
        
    }else{
        HomeCell *cell = (HomeCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [cell.tagNewImageView setHidden:YES];
        Item *item = self.items[indexPath.row];
        HomeDetailVC *vc = [[HomeDetailVC alloc] init];
        vc.itemId = item.itemId;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }

    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 265);
    }else {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * kMargin, kItemHeight);;
    }
 
}

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

@end
