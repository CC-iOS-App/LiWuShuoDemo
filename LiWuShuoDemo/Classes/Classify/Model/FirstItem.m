//
//  FirstItem.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/6/4.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "FirstItem.h"
#import "MJExtension.h"

@implementation FirstItem


@end



@implementation Channel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"channels":[SecondItem class]};
}


@end



@implementation SecondItem



@end