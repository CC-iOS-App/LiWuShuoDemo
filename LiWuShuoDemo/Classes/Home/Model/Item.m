//
//  Item.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/22.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "Item.h"
#import "MJExtension.h"

@implementation Item

- (CGSize)likesLabelSize
{
    return [[NSString stringWithFormat:@"%d",_likes_count] boundingRectWithSize:CGSizeMake(MAXFLOAT, 14) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil].size;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"itemId" : @"id"};
}

- (NSURL *)detailURL
{
    NSString *url = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/posts/%@?",_itemId];
    return [NSURL URLWithString:url];
}



@end
