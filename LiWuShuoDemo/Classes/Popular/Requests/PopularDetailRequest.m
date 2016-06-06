//
//  PopularDetailRequest.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/6/4.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "PopularDetailRequest.h"

@implementation PopularDetailRequest

- (NSString *)requestURL
{
    return [NSString stringWithFormat:@"http://api.liwushuo.com/v2/items/%@?",self.itemId];
}

- (RequestMethod)requestMethod
{
    return RequestMethodGet;
}

@end
