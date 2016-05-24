//
//  PopularItemRequest.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/23.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "PopularItemRequest.h"

@implementation PopularItemRequest

- (NSString *)requestURL
{
    return @"http://api.liwushuo.com/v2/items";
}

- (NSDictionary *)parameters
{
    return @{@"gender"    :@"1",
             @"generation":@"2",
             @"limit"     :@"50",
             @"offset"    :@"0"};
}

@end

@implementation MoreItemRequest

- (NSString *)requestURL
{
    return @"http://api.liwushuo.com/v2/items?generation=2&gender=1&limit=50&offset=50";
}

//- (NSDictionary *)parameters
//{
//    return @{@"gender"    :@"2",
//             @"generation":@"2",
//             @"limit"     :@"50",
//             @"offset"    :@"0"};
//}

@end
