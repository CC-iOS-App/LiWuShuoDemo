//
//  TopView.h
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/26.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BannerDidClicked)(id banner);

@class BannerView;
@interface TopView : UIView

@property (nonatomic, copy) BannerDidClicked bannerDidClicked;

@property (nonatomic, strong) NSArray *banners;
@property (nonatomic, strong) NSArray *secondBanners;

@property (nonatomic, weak)   BannerView *bannerView;

@end


@class SecondBanner;
@interface SecondBannerCell : UICollectionViewCell

@property (nonatomic, strong) SecondBanner *banner;

@end