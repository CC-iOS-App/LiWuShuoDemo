//
//  ScrollPageView.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/25.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "ScrollPageView.h"
#import "UIView+FrameExtension.h"
#import "ScrollContentView.h"
#import "ScrollSegmentView.h"

static CGFloat const kSegmentHeight = 35.0;

@interface ScrollPageView ()

@property (nonatomic, weak) ScrollContentView *contentView;
@property (nonatomic, weak) ScrollSegmentView *segmentView;
@property (nonatomic, weak) UIViewController *parentVC;

@property (strong, nonatomic) NSArray *childVcs;
@property (strong, nonatomic) NSMutableArray *titles;

@end

@implementation ScrollPageView

//懒加载
- (NSArray *)childVcs
{
    if (!_childVcs) {
        _childVcs = [NSArray array];
    }
    return _childVcs;
}

- (NSMutableArray *)titles
{
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}

- (ScrollContentView *)contentView
{
    if (!_contentView) {
        ScrollContentView *contentView = [[ScrollContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segmentView.frame), self.width, self.height - CGRectGetMaxY(self.segmentView.frame)) childVCs:self.childVcs segmentView:self.segmentView parentVC:self.parentVC];
        [self addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}

- (ScrollSegmentView *)segmentView
{
    if (!_segmentView) {
        
        __weak typeof(self) weakSelf = self;
        ScrollSegmentView *segmentView = [[ScrollSegmentView alloc] initWithFrame:CGRectMake(0, 0, self.width, kSegmentHeight) titles:self.titles titleLabelClicked:^(UILabel *label, NSInteger index) {
            [weakSelf.contentView setContentOffset:CGPointMake(self.width * index, 0)];
        }];
        [self addSubview:segmentView];
        _segmentView = segmentView;
    }
    return _segmentView;
}

- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC
{
    if (self = [super initWithFrame:frame]) {
        self.childVcs = childVCs;
        self.parentVC = parentVC;
        
        for (UIViewController *vc in self.childVcs) {
            [self.titles addObject:vc.title];
        }
        
        self.segmentView.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setExtraBtnClicked:(ExtraBtnClicked)extraBtnClicked
{
    _extraBtnClicked = extraBtnClicked;
    self.segmentView.extraBtnClicked = extraBtnClicked;
}










@end
