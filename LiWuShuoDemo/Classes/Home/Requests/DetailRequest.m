//
//  DetailRequest.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/6/2.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "DetailRequest.h"

@implementation DetailRequest

- (RequestMethod)requestMethod
{
    return RequestMethodGet;
}

- (NSString *)requestURL
{
    return [NSString stringWithFormat:@"http://api.liwushuo.com/v2/posts/%@?",self.itemId];
}

@end
