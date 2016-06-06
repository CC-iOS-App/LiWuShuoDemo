//
//  DetailItem.h
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/6/2.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailItem : NSObject

@property (nonatomic, copy) NSString *content_html;
@property (nonatomic, assign) int comments_count;
@property (nonatomic, assign) int likes_count;
@property (nonatomic, assign) int shares_count;

@property (nonatomic, strong) NSURL *cover_image_url;
@property (nonatomic, copy) NSString *title;

@end
