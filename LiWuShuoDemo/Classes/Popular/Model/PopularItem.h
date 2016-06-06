//
//  PopularItem.h
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/23.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PopularItem : NSObject

@property (nonatomic, strong) NSURL *cover_image_url;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int favorites_count;
@property (nonatomic, assign) float price;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, copy) NSString *itemId;

@end

//@interface SuperItem : NSObject
//
//@property (nonatomic, strong) NSArray *items;
//
//@end

@interface DataNType : NSObject
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) PopularItem *data;

@end

