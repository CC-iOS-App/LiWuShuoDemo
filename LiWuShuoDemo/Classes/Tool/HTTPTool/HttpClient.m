//
//  HttpClient.m
//  GitHubClient
//
//  Created by XUN WANG on 16/5/11.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "HttpClient.h"
#import "BaseRequest.h"
#import "AFHTTPSessionManager.h"
#import "AFURLRequestSerialization.h"
#import "AFURLResponseSerialization.h"
#import "HttpConfiguration.h"

@interface HttpClient ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) HttpConfiguration *configuration;
@property (nonatomic, strong) NSMutableArray *requests;

@end

@implementation HttpClient

- (NSMutableArray *)requests
{
    if (!_requests) {
        _requests = [NSMutableArray array];
    }
    return _requests;
}

+ (instancetype)sharedInstance
{
    static HttpClient *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HttpClient alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    if (self = [super init]) {
        _manager = [AFHTTPSessionManager manager];
        _configuration = [HttpConfiguration sharedInstance];
    }
    return self;
}

#pragma mark - private method
- (NSString *)getRequestURL:(BaseRequest *)request
{
    NSString *URLString = request.requestURL;
    if ([URLString hasPrefix:@"http"]) {
        return URLString;
    }
    
    NSString *url = nil;
    if (request.baseURL.length) {
        url = request.baseURL;
    }else if (_configuration.baseURL.length) {
        NSLog(@"%@",_configuration.baseURL);
        url = _configuration.baseURL;
    }
    return [NSString stringWithFormat:@"%@%@",url,URLString];
}

- (void)addRequest:(BaseRequest *)request
{
    [self.requests addObject:request];
    if (request.requestSerializerType == RequestSerializerTypeJSON) {
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }else if (request.requestSerializerType == RequestSerializerTypeHTTP) {
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }

    //添加HTTP headers
    [self getHTTPHeadersFromDic:_configuration.httpHeaders]; //Normal HTTP Headers from configuration
    [self getHTTPHeadersFromDic:request.extraHTTPHeaders];    //extra HTTP Headers from request
    
    
    if ([request useCacheData]) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:request.requestURL] length]) {
            [_manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:request.requestURL] forHTTPHeaderField:@"If-None-Match"];
            _manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
        }
    }
 
    if (request.acceptableResponseContentType.count) {
        NSMutableSet *set = [_manager.responseSerializer.acceptableContentTypes mutableCopy];
        [set addObjectsFromArray:request.acceptableResponseContentType];
          _manager.responseSerializer.acceptableContentTypes = set;
    }
  
    //add 304 statusCode
    NSMutableIndexSet *set = [_manager.responseSerializer.acceptableStatusCodes mutableCopy];
    [set addIndex:304];
    _manager.responseSerializer.acceptableStatusCodes = set;
    
    //GET
    if (request.requestMethod == RequestMethodGet) {
        request.sessionDataTask = [_manager GET:[self getRequestURL:request] parameters:request.parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSHTTPURLResponse *response = ( NSHTTPURLResponse *)task.response;
            if (response.statusCode == 304) {
                
            }else {//200,new data,new etag
                if ([response.allHeaderFields[@"Etag"] length]) {
                    [[NSUserDefaults standardUserDefaults] setObject:response.allHeaderFields[@"Etag"] forKey:request.requestURL];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
               
            }
            
            
            if (request.requestFinishedCallBack) {
                request.requestFinishedCallBack(nil, responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (request.requestFinishedCallBack) {
                request.requestFinishedCallBack(error, nil);
            }
        }];
    }
    
    //POST
    if (request.requestMethod == RequestMethodPost) {
        request.sessionDataTask = [_manager POST:[self getRequestURL:request] parameters:request.parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (request.requestFinishedCallBack) {
                request.requestFinishedCallBack(nil, responseObject);
                NSLog(@"%@",responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (request.requestFinishedCallBack) {
                request.requestFinishedCallBack(error, nil);
            }
        }];
    }
}

- (void)getHTTPHeadersFromDic:(NSDictionary *)dictionary
{
    if (dictionary != nil) {
        NSArray *keys = dictionary.allKeys;
        for (NSString *key in keys) {
            [_manager.requestSerializer setValue:dictionary[key] forHTTPHeaderField:key];
        }
    }
}

- (void)cancelAllRequest
{
    for (BaseRequest *request in self.requests) {
        [request cancel];
    }
    [self.requests removeAllObjects];
}

- (void)clearCache
{
    
}


@end
