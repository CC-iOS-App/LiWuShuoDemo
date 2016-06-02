//
//  Item.h
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/22.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Item : NSObject

@property (nonatomic, strong) NSURL *cover_image_url;
@property (nonatomic, assign) int likes_count;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSURL *content_url;

@property (nonatomic, assign) CGSize likesLabelSize;

@property (nonatomic, copy) NSString *itemId;

@property (nonatomic, strong) NSURL *detailURL;


@end
