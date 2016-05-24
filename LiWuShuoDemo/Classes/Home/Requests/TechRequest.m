//
//  TechRequest.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/24.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "TechRequest.h"

@implementation TechRequest

- (RequestMethod)requestMethod
{
    return RequestMethodGet;
}

- (NSString *)requestURL
{
    return @"http://api.liwushuo.com/v2/channels/28/items?gender=1&generation=2&limit=20&offset=0";
}

@end

@implementation LoadMoreTechRequest

- (RequestMethod)requestMethod
{
    return RequestMethodGet;
}

- (NSString *)requestURL
{
    return @"http://api.liwushuo.com/v2/channels/28/items?generation=2&gender=1&limit=20&offset=20";
}

@end
