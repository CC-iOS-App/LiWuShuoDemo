//
//  ScrollContentView.h
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/25.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScrollSegmentView;
@interface ScrollContentView : UIView

- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSArray *)childVCs segmentView:(ScrollSegmentView *)segmentView parentVC:(UIViewController *)parentVC;

- (void)setContentOffset:(CGPoint)offset;

@end
