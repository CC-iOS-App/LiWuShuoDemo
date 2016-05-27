//
//  ScrollPageView.h
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/25.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ExtraBtnClicked)(UIButton *extraBtn);

@interface ScrollPageView : UIView

@property (nonatomic, copy) ExtraBtnClicked extraBtnClicked;

- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC;

@end
