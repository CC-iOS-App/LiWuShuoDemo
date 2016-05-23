//
//  HttpConfiguration.m
//  GitHubClient
//
//  Created by XUN WANG on 16/5/11.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "HttpConfiguration.h"


@implementation HttpConfiguration

+ (instancetype)sharedInstance
{
    static HttpConfiguration *configuration = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configuration = [[HttpConfiguration alloc] init];
    });
    return configuration;
}

@end
