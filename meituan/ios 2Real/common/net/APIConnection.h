//
//  APIConnection.h
//  Youxian100
//
//  Created by Lessu on 13-3-27.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//
// version 1.01
// update preproccess data
// v1.01+aichi
// v1.1
// url with '?' inside,can add params now.
// edit preproccess block method
// Added by lessu 2013 11 25
// v1.2
// update post params,it can support array type now
// v1.3
// 新增带apiconnection缓存
// v1.4 
// 修正一些bug ，加上chach block，取消firstload mode

// v1.5 加入soap类型
// v1.5 加入responseFormat 处理
#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "APIConnection.h"


extern NSString* const DhServerOperationFailedDomain;
extern NSString* const APINetwordFailedDomain;

extern NSString* kAPIConnectionStandartSuccessKey;
extern NSString* kAPIConnectionStandartDataKey;
extern NSString* kAPIConnectionStandartMessageKey;

typedef void (^APIConnectionCompleteBlock)(id result);
typedef void (^APIConnectionFailedBlock)(NSError* error);
typedef void (^APIConnectionFinalBlock)();
typedef enum{
    kAPIConnectionTypePlain = 0,
    kAPIConnectionTypeJSON,
    kAPIConnectionTypeStandart
    
} APIConnectionResultType;

@interface APIConnection : ASIFormDataRequest
{
    APIConnectionResultType         _resultType;
    BOOL                            _usingCache;
    NSDictionary                    *_params;
}
//@property(nonatomic,readonly) ASIHTTPRequest            *request;
@property(nonatomic,copy) void (^onSuccess)(id result);
@property(nonatomic,copy) void (^onFailed)(NSError* error);
@property(nonatomic,copy) void (^onFinal)();
@property(nonatomic,copy) void (^onCacheSuccess)(id result);

@property(nonatomic,assign)APIConnectionResultType      resultType;

@property(nonatomic,copy)   NSDictionary*               params;
@property(nonatomic,copy) void (^preproccess)     (NSDictionary *input,BOOL *success,id* data,NSString **message);
@property(nonatomic,copy) void (^responseFormat)  (NSString *input,NSString **output);


/**
 *  First Load Mode 是指，不管何时都是使用缓存，然后使用缓存同时，会根据缓存策略加载一次网络
 */
//@property(nonatomic,assign) BOOL                        isFirstLoadMode;
//@property(nonatomic,assign) BOOL                        firstLoadDontCall;

@property(nonatomic,copy) NSString* requestUrl;

- (id)      initWithConnectionUrlString:(NSString *)requestUrl;
- (void)    startAsynchronous;
- (void)    startSynchronous;

@property(nonatomic,assign) BOOL                        addCache;
@property(nonatomic,assign) BOOL                        isCacheLoading;
- (void)    loadFromCache;

- (void)prepareForRequest;
- (void)    onConnectionCompelte:(NSString *)responseString;
- (void)    enableCache;
- (void)    disableCache;

- (void)    setURLString:(NSString *)urlString;

- (void)    setSuccessTarget:(id)target selector:(SEL)selector;
- (void)    setFailedTarget:(id)target selector:(SEL)selector;
- (void)    setCacheSuccessTarget:(id)target selector:(SEL)selector;

+ (NSString *)urlString:(NSString *)urlString withParams:(NSDictionary *)params;

@end
id           apiFilterObject(id object);

