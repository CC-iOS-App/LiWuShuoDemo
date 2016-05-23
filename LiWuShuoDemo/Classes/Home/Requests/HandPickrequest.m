//
//  handPickrequest.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/23.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "HandPickrequest.h"

@implementation HandPickrequest

- (RequestMethod)requestMethod
{
    return RequestMethodGet;
}

- (NSString *)requestURL
{
    return @"http://api.liwushuo.com/v2/channels/101/items";
}

- (NSDictionary *)parameters
{
    return @{@"ad"        :@"2",
             @"gender"    :@"1",
             @"generation":@"2",
             @"limit"     :@"20",
             @"offset"    :@"0"};
}

@end
