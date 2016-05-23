//
//  HomeCollectionVC.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/22.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "HomeCollectionVC.h"
#import "UIImage+Extension.h"
#import "HomeCell.h"
#import "HandPickrequest.h"
#import "MJExtension.h"
#import "Item.h"
#import "AFNetworking.h"

static CGFloat const kMargin     = 10;
static CGFloat const kItemHeight = 160;

@interface HomeCollectionVC ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation HomeCollectionVC

static NSString * const kReuseIdentifier = @"Cell";

- (NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setUpNavigationItems];
    [self setFlowLayout];
     self.collectionView.backgroundColor = [UIColor whiteColor];
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellWithReuseIdentifier:kReuseIdentifier];
    
    [self getDataBack];
    
    // Do any additional setup after loading the view.
}

- (void)setFlowLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * kMargin, kItemHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = kMargin;
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
}

- (void)setUpNavigationItems
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_logo"]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage nonRenderingImageName:@"icon_navigation_search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchItemClicked)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage nonRenderingImageName:@"feed_signin"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClicked)];
}

- (void)getDataBack
{
    HandPickrequest *request = [[HandPickrequest alloc] init];
    [request starWithFinishedBlock:^(NSError *error, id result) {
        NSLog(@"error is:%@",error);
        if (!error) {
            self.items = [Item mj_objectArrayWithKeyValuesArray:[result[@"data"] objectForKey:@"items"]];
            [self.collectionView reloadData];
        }
    }];
}

- (void)searchItemClicked
{
    
}

- (void)leftBarButtonItemClicked
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseIdentifier forIndexPath:indexPath];
    
    Item * item = self.items[indexPath.row];
    cell.item = item;
//    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    HomeCell *cell = (HomeCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell.tagNewImageView setHidden:YES];
    
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
