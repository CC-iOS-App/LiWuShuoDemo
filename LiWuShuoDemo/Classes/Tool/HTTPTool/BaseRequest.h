//
//  BaseRequest.h
//  GitHubClient
//
//  Created by XUN WANG on 16/5/11.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestCallBack)(NSError *error, id result);

typedef NS_ENUM(NSInteger, RequestMethod) {
    RequestMethodGet = 0,
    RequestMethodPost,
    RequestMethodPut,
    RequestMethodDelete
};

typedef NS_ENUM(NSInteger, RequestSerializerType) {
    RequestSerializerTypeJSON = 0,
    RequestSerializerTypeHTTP
};

@interface BaseRequest : NSObject

@property (nonatomic, strong) NSURLSessionDataTask *sessionDataTask;
@property (nonatomic, copy) RequestCallBack requestFinishedCallBack;

@property (nonatomic, strong, readonly) id responseObject;
@property (nonatomic, strong, readonly) NSDictionary *responseJSON;

- (RequestMethod)requestMethod;

- (RequestSerializerType)requestSerializerType;

- (NSString *)baseURL;

- (NSString *)requestURL;

- (NSDictionary *)extraHTTPHeaders;

- (NSArray *)acceptableResponseContentType;

- (NSDictionary *)parameters;

- (BOOL)isCacheData;

- (BOOL)useCacheData;

- (void)starWithFinishedBlock:(RequestCallBack)finishedCallBack;

- (void)pause;

- (void)cancel;

@end

