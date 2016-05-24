//
//  UIColor+CustomColor.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/22.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "UIColor+CustomColor.h"

@implementation UIColor (CustomColor)

+ (instancetype)themeColor
{
    return [self colorWithRed:251.0/255 green:14.0/255 blue:56.0/255 alpha:1];
}

+ (instancetype)collectionBackgroundColor
{
    return [self colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1];
}

@end
