//
//  HttpConfiguration.h
//  GitHubClient
//
//  Created by XUN WANG on 16/5/11.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HttpConfiguration : NSObject

@property (nonatomic, copy) NSString *baseURL;

@property (nonatomic, strong) NSDictionary *httpHeaders;

+ (instancetype)sharedInstance;

@end
