//
//  API.m
//  SeeCollection
//
//  Created by Lessu on 13-2-26.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "API.h"
#import "ASIHTTPRequest.h"
#import "NSString+SBJSON.h"
#import "APIConnection+Cache.h"
#import "SOAPConnection.h"
static NSString * serverUrl = @"www.scetia.com/";
//static NSDictionary *apiUrl;



//static NSString const * APISiteUrlKey       = @"siteUrl";
//static NSString const * APIHTTPMethodKey    = @"http";
//static NSString const * APIPreprocessKey    = @"preprocess";
//static NSString const * APIResultFormatKey  = @"responseFormat";
//static NSString const * APISoapUrlKey       = @"soapUrl";
@interface API (){

}
@end

@implementation API
static API *        sharedApi;
+ (API *)sharedInstance{
    if (sharedApi == NULL) {
        sharedApi = [[API alloc]init];
    }
    return sharedApi;
}
//+ (NSDictionary *)apiConfig{
//    return [API sharedInstance]apiConfig;
//}
- (id)init{
    self = [super init];
    if (self) {
        _apiConfig = @{
                        APISiteUrlKey           : @"www.scetia.com/scetia.app.ws/ServiceUST.asmx",
                        APIHTTPMethodKey        : @"http",
                    };
        
        _apiMethod = @{

                    };

    }
    return self;
}
- (void)setServerUrl:(NSString *)serverUrl{
    _apiConfig = [_apiConfig mutableCopy];
    ((NSMutableDictionary *)_apiConfig)[APISiteUrlKey] = [NSString stringWithFormat:@"%@/scetia.app.ws/ServiceUST.asmx",serverUrl];
}
- (APIConnection *)connectionWithRelativeUrlString:(NSString *) url params:(NSDictionary *)params{
    NSString *requestUrl = [self getUrlStringByApiName:url];
    APIConnection *connection = [[APIConnection alloc]initWithConnectionUrlString:requestUrl];
    [connection setResultType:kAPIConnectionTypeJSON];
    [connection setUseCookiePersistence:YES];
    [connection disableCache];
    [connection setResultType:kAPIConnectionTypeStandart];
    if (_apiConfig[APIPreprocessKey]) {
        [connection setPreproccess:_apiConfig[APIPreprocessKey]];
    }
    return connection; //zxg 4.25
}


- (APIConnection *)connectionWithApiName:(NSString *) apiName params:(NSDictionary *)params{
    NSDictionary *apiOptions = _apiMethod[apiName];
    NSAssert(DICTIONARY_NOT_EMPTY(apiOptions), @"Cannot find method");
    
    if (STRING_NOT_EMPTY(apiOptions[API_CONNECT_METHOD])) {
        
    }else{
        
    }
    
    APIConnection *connection;
    if ([apiOptions[API_CONNECT_METHOD] isEqualToString:API_CONNECT_METHOD_SOAP]) {
        NSString *requestUrl = [NSString stringWithFormat:@"%@://%@" ,_apiConfig[APIHTTPMethodKey], _apiConfig[APISiteUrlKey]];
        SOAPConnection *sconnection = [[SOAPConnection alloc]initWithConnectionUrlString:requestUrl];
        sconnection.soapActionUrl = _apiConfig[APISoapUrlKey];
        sconnection.soapAction    = apiOptions[API_SOAP_ACTION];
        connection = sconnection;
    }else{
        NSString *requestUrl = [self getUrlStringByApiName:apiName];
        connection = [[APIConnection alloc]initWithConnectionUrlString:requestUrl];
    }
    
    [connection setResultType:kAPIConnectionTypeJSON];
    
    [connection setUseCookiePersistence:YES];
    if (STRING_NOT_EMPTY(apiOptions[API_CACHE_ENABLE])&&[apiOptions[API_CACHE_ENABLE] boolValue]) {
        [connection enableCache];
        [connection setCachePolicy:[apiOptions[API_CACHE] integerValue]];
        [connection setSecondsToCache:15*60];
    }else{
        [connection disableCache];
    }
    if (_apiConfig[APIPreprocessKey]) {
        [connection setPreproccess:_apiConfig[APIPreprocessKey]];
    }
    if (_apiConfig[APIResultFormatKey]) {
        [connection setResponseFormat:_apiConfig[APIResultFormatKey]];
    }
    if (STRING_NOT_EMPTY(apiOptions[API_CONNECT_METHOD])) {
        [connection setRequestMethod:apiOptions[API_CONNECT_METHOD]];
    }else{
        [connection setRequestMethod:API_CONNECT_METHOD_GET];
    }
    if (apiOptions[API_RESULT_TYPE]) {
        [connection setResultType:[apiOptions[API_RESULT_TYPE] intValue]];
    }else{
        [connection setResultType:kAPIConnectionTypeStandart];
    }
    
//    if (STRING_NOT_EMPTY(apiOptions[API_FIRSTLOAD_ENABLE])) {
//        if (STRING_NOT_EMPTY(apiOptions[API_FIRSTLOAD_DONT_CALL]) ) {
//            connection  .firstLoadDontCall = [apiOptions[API_FIRSTLOAD_ENABLE] boolValue];
//        }else{
//            connection  .firstLoadDontCall = true;
//        }
//        connection .isFirstLoadMode = [apiOptions[API_FIRSTLOAD_ENABLE] boolValue];
//    }else{
//        connection .isFirstLoadMode = false;
//    }
    connection.params = params;

    return connection;
}
- (id)cacheForApiName:(NSString *)apiName params:(NSDictionary *)params{
    NSDictionary *apiOptions = _apiMethod[apiName];
    NSString *requestUrl = [self getUrlStringByApiName:apiName];

    if (STRING_NOT_EMPTY(apiOptions[API_CONNECT_METHOD])) {
        if ([apiOptions[API_CONNECT_METHOD] isEqualToString:API_CONNECT_METHOD_GET]) {
            return [APIConnection cacheForGetWithUrl:requestUrl andParams:params];            
        }else {
            return [APIConnection cacheForPostWithUrl:requestUrl andParams:params];
        }
    }else{
        return [APIConnection cacheForGetWithUrl:requestUrl andParams:params];
        
    }
    return nil;
}
/**
 *根据请求名得到 请求url，不包括参数
 */
- (NSString *)getUrlStringByApiName:(NSString *)apiName{
    NSDictionary *apiOptions = _apiMethod[apiName];
    NSString *requestUrl = apiOptions[API_URL];
    return [NSString stringWithFormat:@"%@://%@%@" ,_apiConfig[APIHTTPMethodKey], _apiConfig[APISiteUrlKey] ,requestUrl];

}

+ (NSArray *)convertXMLArray:(NSArray *)xmlArray{
    NSMutableArray *newArray = [[NSMutableArray alloc]init];
    for (NSDictionary *itemDictionary in xmlArray){
        [newArray addObject:[self convertXMLDictionary:itemDictionary]];
    }
    return newArray;
}

+ (NSDictionary *)convertXMLDictionary:(NSDictionary *)xmlDictionary{
    NSEnumerator *enu = [xmlDictionary keyEnumerator];
    NSMutableDictionary *newItem = [[NSMutableDictionary alloc]init];
    for(NSString *key in enu){
        if(xmlDictionary[key][@"value"]!=nil) {
            newItem[key] = xmlDictionary[key][@"value"];
        }else{
            newItem[key] = @"";
        }
    }
    return newItem;
}


- (NSString *)absoluteUrlStringWithRelativeUrl:(NSString *)relative{
    return [NSString stringWithFormat:@"%@://%@%@" ,_apiConfig[APIHTTPMethodKey], _apiConfig[APISiteUrlKey] ,relative];
}
#if NS_BLOCKS_AVAILABLE
#endif
@end