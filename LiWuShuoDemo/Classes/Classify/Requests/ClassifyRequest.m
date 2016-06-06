//
//  ClassifyRequest.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/6/6.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "ClassifyRequest.h"

@implementation ClassifyRequest

- (NSString *)requestURL
{
    return @"http://api.liwushuo.com/v2/collections?limit=6&offset=0";
}

- (RequestMethod)requestMethod
{
    return RequestMethodGet;
}

@end

@implementation ChannelsRequest

- (NSString *)requestURL
{
    return @"http://api.liwushuo.com/v2/channel_groups/all?";
}

- (RequestMethod)requestMethod
{
    return RequestMethodGet;
}

@end
