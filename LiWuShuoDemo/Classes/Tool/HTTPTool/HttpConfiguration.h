//
//  HttpConfiguration.h
//  GitHubClient
//
//  Created by XUN WANG on 16/5/11.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import <Foundation/Foundation.h>

//FOUNDATION_EXPORT NSString * const kBaseURL;
//FOUNDATION_EXPORT NSString * const kClientID;
//FOUNDATION_EXPORT NSString * const kClientSecret;
//
//FOUNDATION_EXPORT NSString * const kAuthorizeURL;
//FOUNDATION_EXPORT NSString * const kRedirect_uri;
//FOUNDATION_EXPORT NSString * const kScope;

@interface HttpConfiguration : NSObject

@property (nonatomic, copy) NSString *baseURL;

@property (nonatomic, strong) NSDictionary *httpHeaders;

+ (instancetype)sharedInstance;

@end
