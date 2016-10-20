//
//  API.h
//  SeeCollection
//
//  Created by Lessu on 13-2-26.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//
// v1.01
// update preproccess data
// v1.2
// 新增带apiconnection缓存
// v1.3
// 多API存在允许

#import <Foundation/Foundation.h>
#import "APIConnection.h"
#import "APIMehod.h"
@class ASIHTTPRequest;

//static NSString const * APISiteUrlKey;
//static NSString const * APIHTTPMethodKey;
//static NSString const * APIPreprocessKey;
//static NSString const * APIResultFormatKey;
//static NSString const * APISoapUrlKey;
#define APISiteUrlKey        @"siteUrl"
#define APIHTTPMethodKey     @"http"
#define APIPreprocessKey     @"preprocess"
#define APIResultFormatKey   @"responseFormat"
#define APISoapUrlKey        @"soapUrl"
@interface API : NSObject{
    ASIHTTPRequest *_request;
    NSDictionary *_apiConfig;
    NSDictionary *_apiMethod;
}
@property(nonatomic,readonly) NSDictionary *apiConfig;
@property(nonatomic,readonly) NSDictionary *apiMethod;

- (void)setServerUrl:(NSString *)serverUrl;

- (id)init;


+ (API *)sharedInstance;
//+ (NSDictionary *)apiConfig;
- (APIConnection *)connectionWithRelativeUrlString:(NSString *) url params:(NSDictionary *)params;
- (APIConnection *)connectionWithApiName:(NSString *) apiName params:(NSDictionary *)params;
- (NSString *)getUrlStringByApiName:(NSString *)apiName;
- (NSString *)absoluteUrlStringWithRelativeUrl:(NSString *)relative;
- (id)cacheForApiName:(NSString *)apiName params:(NSDictionary *)params;
@end

#define API_DEF(url,method)           @{API_URL: url ,API_CONNECT_METHOD : method}
#define API_DEF_GET(url)              @{API_URL: url}
#define API_DEF_POST(url)             @{API_URL: url,API_CONNECT_METHOD : API_CONNECT_METHOD_POST}
#define API_DEF_SOAP(action)          @{API_SOAP_ACTION:action , API_CONNECT_METHOD : @"SOAP"}
//#define (.+)
//-> #define $1 @"$1"
