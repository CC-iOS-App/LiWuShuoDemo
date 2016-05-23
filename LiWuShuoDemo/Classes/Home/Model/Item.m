//
//  Item.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/22.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "Item.h"

@implementation Item

- (CGSize)likesLabelSize
{
    return [[NSString stringWithFormat:@"%d",_likes_count] boundingRectWithSize:CGSizeMake(MAXFLOAT, 14) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil].size;
}

@end
