//
//  PopularToolBar.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/6/4.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "PopularToolBar.h"

@implementation PopularToolBar

+ (instancetype)toolBar
{
    return [[[NSBundle mainBundle] loadNibNamed:@"PopularToolBar" owner:nil options:nil] lastObject];
}


- (IBAction)likesBtnDidClicked:(UIButton *)sender
{
    if (sender.selected) {
        [sender setTitle:@"喜欢" forState:UIControlStateNormal];
        
    }else {
        [sender setTitle:@"已喜欢" forState:UIControlStateNormal];
    }
    sender.selected = !sender.isSelected;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values   = @[@0.95,@1.2,@1];
    animation.keyTimes = @[@0.1,@0.6,@1];
    [sender.imageView.layer addAnimation:animation forKey:nil];
    
}

@end
