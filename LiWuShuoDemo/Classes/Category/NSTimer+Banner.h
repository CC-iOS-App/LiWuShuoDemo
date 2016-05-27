//
//  NSTimer+Banner.h
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/26.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Banner)

- (void)pauseTimer;

- (void)resumeTimer;

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
