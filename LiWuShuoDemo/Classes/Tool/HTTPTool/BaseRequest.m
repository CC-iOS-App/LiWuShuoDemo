//
//  BaseRequest.m
//  GitHubClient
//
//  Created by XUN WANG on 16/5/11.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "BaseRequest.h"
#import "HttpClient.h"

@implementation BaseRequest

- (RequestMethod)requestMethod
{
    return RequestMethodGet;
}

- (RequestSerializerType)requestSerializerType
{
    return RequestSerializerTypeJSON;
}

- (NSString *)baseURL
{
    return @"";
}

- (NSString *)requestURL
{
    return @"";
}

- (NSDictionary *)extraHTTPHeaders
{
    return nil;
}

- (NSArray *)acceptableResponseContentType
{
    return nil;
}

- (NSDictionary *)parameters
{
    return nil;
}

- (BOOL)isCacheData
{
    return NO;
}

- (BOOL)useCacheData
{
    return NO;
}

- (void)starWithFinishedBlock:(RequestCallBack)finishedCallBack
{
    _requestFinishedCallBack=finishedCallBack;
    [[HttpClient sharedInstance] addRequest:self];
    [self.sessionDataTask resume];
}

- (void)pause
{
    [_sessionDataTask suspend];
}

- (void)cancel
{
    [_sessionDataTask cancel];
}


@end
