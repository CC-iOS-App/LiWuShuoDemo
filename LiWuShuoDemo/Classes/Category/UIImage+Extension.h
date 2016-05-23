//
//  UIImage+Extension.h
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/22.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+ (instancetype)nonRenderingImageName:(NSString *)imageName;

+ (instancetype)strechableImageWithName:(NSString *)imageName;

@end
