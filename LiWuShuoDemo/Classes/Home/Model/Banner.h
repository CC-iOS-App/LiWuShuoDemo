//
//  Banners.h
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/18.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Banner : NSObject

@property (nonatomic, strong) NSURL *image_url;
@property (nonatomic, copy) NSString *type;


@end

@interface SecondBanner : NSObject
@property (nonatomic, strong) NSURL *image_url;

@end
