//
//  HttpClient.h
//  GitHubClient
//
//  Created by XUN WANG on 16/5/11.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseRequest;
@interface HttpClient : NSObject

+ (instancetype)sharedInstance;

- (void)addRequest:(BaseRequest *)request;

- (void)clearCache;

- (void)cancelAllRequest;

@end
