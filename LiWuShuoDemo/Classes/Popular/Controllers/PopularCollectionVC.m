//
//  PopularCollectionVC.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/22.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "PopularCollectionVC.h"
#import "UIImage+Extension.h"
#import "UIColor+CustomColor.h"
#import "PopularItemRequest.h"
#import "MJExtension.h"
#import "PopularItem.h"
#import "PopularCell.h"
#import "MJRefresh.h"

static CGFloat const kMargin     = 10;
static CGFloat const kItemHeight = 243;
static NSString * const reuseIdentifier = @"PopularCell";

@interface PopularCollectionVC ()

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) NSArray *refreshImages;

@end

@implementation PopularCollectionVC

- (NSArray *)refreshImages
{
    if (!_refreshImages) {
        _refreshImages = @[[UIImage imageNamed:@"box_01"],[UIImage imageNamed:@"box_02"],[UIImage imageNamed:@"box_03"],[UIImage imageNamed:@"box_04"],[UIImage imageNamed:@"box_05"],[UIImage imageNamed:@"heart"],[UIImage imageNamed:@"box_05"],[UIImage imageNamed:@"box_04"],[UIImage imageNamed:@"box_03"],[UIImage imageNamed:@"box_02"],[UIImage imageNamed:@"box_01"]];
    }
    return _refreshImages;
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
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"PopularCell" bundle:nil] forCellWithReuseIdentifier:
     reuseIdentifier];

    [self setFlowLayout];
    [self setUpNavigationItems];
    
    [self setRefreshHeaderFooter];
//    [self.collectionView.mj_header beginRefreshing];
    [self loadNewData];
  
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

- (void)loadNewData
{
    PopularItemRequest *request = [[PopularItemRequest alloc] init];
    [request starWithFinishedBlock:^(NSError *error, id result) {
        if (!error) {
            [self.collectionView.mj_header endRefreshing];
            [self.items removeAllObjects];
            self.items = [DataNType mj_objectArrayWithKeyValuesArray:[result[@"data"] objectForKey:@"items"]];
            [self.collectionView reloadData];
        }
    }];
}

- (void)loadMoreData
{
    MoreItemRequest *request = [[MoreItemRequest alloc] init];
    [request starWithFinishedBlock:^(NSError *error, id result) {
        if (!error) {
            [self.collectionView.mj_footer endRefreshing];
            [self.items addObjectsFromArray:[DataNType mj_objectArrayWithKeyValuesArray:[result[@"data"] objectForKey:@"items"]]];
            [self.collectionView reloadData];
        }
    }];
}

- (void)setFlowLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width - 3 * kMargin) * 0.5, kItemHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    layout.minimumLineSpacing = kMargin;
//    layout.minimumInteritemSpacing = kMargin;
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.contentInset = UIEdgeInsetsMake(kMargin, kMargin, 0, kMargin);
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor collectionBackgroundColor];
    
}

- (void)setUpNavigationItems
{
    self.title = @"热门";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage nonRenderingImageName:@"icon_navigation_search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchItemClicked)];
}


- (void)searchItemClicked
{
    NSLog(@"searchBarButtonItem Clicked");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PopularCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    

    DataNType *item = self.items[indexPath.row];
    cell.item = item.data;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

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
