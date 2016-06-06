//
//  FirstItem.h
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/6/4.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstItem : NSObject

@property (nonatomic, strong) NSURL *banner_image_url;

@end

@interface Channel : NSObject

@property (nonatomic, strong) NSArray *channels;
@property (nonatomic, copy) NSString *name;

@end


@interface SecondItem : NSObject

@property (nonatomic, strong) NSURL *icon_url;
@property (nonatomic, copy) NSString *name;

@end