//
//  BannerView.h
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/26.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BannerDidClicked)(id banner);

@interface BannerView : UIView

@property (nonatomic, copy) BannerDidClicked bannerDidClicked;

@property (nonatomic, strong) NSArray *banners;

@end
