//
//  UIView+FrameExtension.h
//  ZhihuDaily demo
//
//  Created by XUN WANG on 16/3/31.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//  Override the getter and setter for the properties below to make it more convienient to code


#import <UIKit/UIKit.h>

@interface UIView (FrameExtension)

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGSize size;

@end
