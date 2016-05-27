//
//  BannerView.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/26.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "BannerView.h"
#import "NSTimer+Banner.h"
#import "UIView+FrameExtension.h"
#import "UIImageView+WebCache.h"
#import "Banner.h"

static CGFloat const kTimerDuration = 3;

@interface BannerView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *contentViews;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, copy) UIImageView *(^getImageViewAtIndex)(NSInteger index);
@property (nonatomic, copy) NSInteger (^totalPagesCount)();
@property (nonatomic, copy) void (^bannerDidClickedAtIndex)(NSInteger index);

@end

@implementation BannerView

{
     NSInteger _currentIndex;
    NSInteger _totalPageCount;
}

- (NSMutableArray *)contentViews
{
    if (!_contentViews) {
        _contentViews = [NSMutableArray array];
    }
    return _contentViews;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpChildViews];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kTimerDuration target:self selector:@selector(timerDidFired) userInfo:nil repeats:YES];
    [self.timer pauseTimer];
    
    return self;
}

- (void)setUpChildViews
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];

    scrollView.contentSize = CGSizeMake(3 * self.width, self.height);
    scrollView.delegate = self;
    scrollView.contentOffset = CGPointMake(self.width, 0);
    scrollView.pagingEnabled = YES;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.x = (self.width - pageControl.width) * 0.5;
    pageControl.y = self.height - 10;
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl = pageControl;
    [self addSubview: pageControl];
    _currentIndex = 0;
    
    
}

- (void)setTotalPagesCount:(NSInteger (^)())totalPagesCount
{
    _totalPageCount = totalPagesCount();
    if (_totalPageCount) {
        [self setUpcontentViews];
        [self.timer resumeTimerAfterTimeInterval:kTimerDuration];
    }
}

- (void)setUpcontentViews
{
     [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self getContentViewsDataSource];
    self.pageControl.numberOfPages = _totalPageCount;
    
    int i = 0;
    for (UIImageView *imgView in self.contentViews) {
        imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidClicked:)];
        [imgView addGestureRecognizer:tap];
        imgView.x = self.width * i;
        [self.scrollView addSubview: imgView];
        i++;
    }
    [self.scrollView setContentOffset:CGPointMake(self.width, 0)];
    
}

- (void)getContentViewsDataSource
{
    NSInteger leftIndex = [self getIndexWithCurrentIndex:_currentIndex - 1];
    NSInteger rightIndex = [self getIndexWithCurrentIndex:_currentIndex + 1];
    
    [self.contentViews removeAllObjects];
    
    if (self.getImageViewAtIndex) {
        [self.contentViews addObject:self.getImageViewAtIndex(leftIndex)];
        [self.contentViews addObject:self.getImageViewAtIndex(_currentIndex)];
        [self.contentViews addObject:self.getImageViewAtIndex(rightIndex)];
    }

}

- (NSInteger)getIndexWithCurrentIndex:(NSInteger)currentIndex
{
    if (currentIndex == -1) {
        return _totalPageCount - 1;
    }else if (currentIndex == _totalPageCount) {
        return 0;
    }else{
        return currentIndex;
    }
}

- (void)timerDidFired
{
    CGPoint updatedOffset = CGPointMake(self.scrollView.contentOffset.x + self.width, 0);
    [self.scrollView setContentOffset:updatedOffset animated:YES];
}

- (void)imageViewDidClicked:(UITapGestureRecognizer *)tap
{
    if (self.bannerDidClickedAtIndex) {
        self.bannerDidClickedAtIndex(_currentIndex);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.timer resumeTimerAfterTimeInterval:kTimerDuration];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int offsetX = scrollView.contentOffset.x;
    if (offsetX >= 2 * self.width) {
        _currentIndex = [self getIndexWithCurrentIndex:_currentIndex + 1];
        [self setUpcontentViews];
    }
    if (offsetX <= 0) {
        _currentIndex = [self getIndexWithCurrentIndex:_currentIndex - 1];
        [self setUpcontentViews];
    }
  
    self.pageControl.currentPage = _currentIndex;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(self.width, 0) animated:YES];
}

- (void)setBanners:(NSArray *)banners
{
    _banners = banners;
    self.totalPagesCount = ^NSInteger(){
        return banners.count;
    };
    __weak typeof(self) weakSelf = self;
    
    self.getImageViewAtIndex = ^UIImageView *(NSInteger index){
        
        UIImageView *imgV = [[UIImageView alloc] init];
        Banner *banner = banners[index];
        imgV.frame = weakSelf.bounds;
        [imgV sd_setImageWithURL:banner.image_url placeholderImage:[UIImage imageNamed:@"scanaddmessage_imageplaceholder"]];
        return imgV;
    };
    
    self.bannerDidClickedAtIndex = ^(NSInteger index){
//        weakSelf.bannerDidClicked(banners[index]);
    };
}



@end
