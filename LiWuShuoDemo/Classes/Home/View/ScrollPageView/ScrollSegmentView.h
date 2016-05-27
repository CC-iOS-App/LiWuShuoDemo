//
//  ScrollSegmentView.h
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/25.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ExtraBtnClicked)(UIButton *extraBtn);
typedef void(^TitleLabelClicked)(UILabel *label, NSInteger index);

@interface ScrollSegmentView : UIView

@property (nonatomic, copy) ExtraBtnClicked extraBtnClicked;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles titleLabelClicked:(TitleLabelClicked)titleLabelClicked;

- (void)adjustUIwhenClickedLabel;


- (void)updateTitleOffsetToCurrentIndex:(NSInteger)index;

- (void)updateUIWithProgress:(CGFloat)progress exindex:(NSInteger)exIndex currentIndex:(NSInteger)currentIndex;

@end
