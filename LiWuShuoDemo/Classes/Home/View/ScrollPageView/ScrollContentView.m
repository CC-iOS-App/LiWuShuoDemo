//
//  ScrollContentView.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/25.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "ScrollContentView.h"
#import "ScrollSegmentView.h"
#import "UIView+FrameExtension.h"

static NSString * const reusedCellID = @"reusedCellID";

@interface ScrollContentView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, weak) ScrollSegmentView *segmentView;

@property (nonatomic, weak) UIViewController *parentVC;

@property (nonatomic, strong) NSArray *childVCs;


@end

@implementation ScrollContentView
{
    NSInteger _exIndex;
    NSInteger _currentIndex;
    CGFloat   _exOffsetX;
}

//懒加载
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
        collectionView.pagingEnabled = YES;
        collectionView.bounces = YES;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reusedCellID];
        [self addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)layout
{
    if (!_layout) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout = layout;
    }
    return _layout;
}

- (NSArray *)childVCs
{
    if (!_childVCs) {
        _childVCs = [NSArray array];
    }
    return _childVCs;
}

- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSArray *)childVCs segmentView:(ScrollSegmentView *)segmentView parentVC:(UIViewController *)parentVC
{
    if (self = [super initWithFrame:frame]) {
        self.childVCs = childVCs;
        self.parentVC = parentVC;
        self.segmentView = segmentView;
        _exIndex = 0;
        _currentIndex = 0;
        _exOffsetX = 0;
        
        self.collectionView.backgroundColor = [UIColor whiteColor];
        for (UIViewController *vc in self.childVCs) {
            [self.parentVC addChildViewController:vc];
        }
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  self.childVCs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusedCellID forIndexPath:indexPath];
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIViewController *vc = self.childVCs[indexPath.row];
    vc.view.frame = self.bounds;
    [cell.contentView addSubview:vc.view];
    [vc didMoveToParentViewController:self.parentVC];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat page = offsetX / self.width;
    CGFloat progress = page - floor(page);
    if (offsetX - _exOffsetX >= 0) {//向右滑
        if (progress == 0) {
            return;
        }
        _exIndex = page;
        _currentIndex = page + 1;
        if (_currentIndex >= self.childVCs.count) {
            _currentIndex = self.childVCs.count - 1;
            return;
        }
    }else {//左滑
        _currentIndex = page;
        _exIndex = page + 1;
        if (_currentIndex < 0) {
            _currentIndex = 0;
            return;
        }
        if (_exIndex >= self.childVCs.count) {
            _exIndex = self.childVCs.count - 1;
            return;
        }
        progress = 1.0 - progress;
    }
    [self.segmentView updateUIWithProgress:progress exindex:_exIndex currentIndex:_currentIndex];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentIndex = scrollView.contentOffset.x / self.width;
    [self.segmentView updateTitleOffsetToCurrentIndex:currentIndex];
    [self.segmentView updateUIWithProgress:1.0 exindex:currentIndex currentIndex:currentIndex];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _exOffsetX = scrollView.contentOffset.x;
}

- (void)setContentOffset:(CGPoint)offset
{
    [self.collectionView setContentOffset:offset animated:NO];
}


@end
