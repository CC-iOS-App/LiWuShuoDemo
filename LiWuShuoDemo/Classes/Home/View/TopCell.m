//
//  TopCell.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/26.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "TopCell.h"
#import "TopView.h"
#import "BannerView.h"
@interface TopCell ()
@property (nonatomic, weak) TopView *topView;

@end

@implementation TopCell

- (TopView *)topView
{
    if (!_topView) {
        TopView *topView = [[TopView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:topView];
        _topView = topView;
    }
    return _topView;
}

- (void)setBanners:(NSArray *)banners
{
    _banners = banners;
    self.topView.bannerView.banners = banners;
}

- (void)setSecondBanners:(NSArray *)secondBanners
{
    _secondBanners = secondBanners;
    self.topView.secondBanners = secondBanners;
}

@end
