//
//  DetailPageTopView.h
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/6/3.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailItem;
@interface DetailPageTopView : UIView

@property (nonatomic, strong) DetailItem *item;


+ (instancetype)detailTopView;

@end
