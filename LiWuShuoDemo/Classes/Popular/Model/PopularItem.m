//
//  PopularItem.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/23.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "PopularItem.h"
#import "MJExtension.h"

@implementation PopularItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
     return @{@"itemId" : @"id"};
}

@end

//@implementation SuperItem
//
//+ (NSDictionary *)mj_objectClassInArray
//{
//    return @{@"items" : [DataNType class]};
//}


//@end

@implementation DataNType



@end