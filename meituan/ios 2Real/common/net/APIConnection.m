//
//  APIConnection.m
//  Youxian100
//
//  Created by Lessu on 13-3-27.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "APIConnection.h"
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"
#import "NSString+SBJSON.h"
#import "APIConnection+Cache.h"

NSString* const DhServerOperationFailedDomain   = @"DhServerOperationFailedDomain";
NSString* const APINetwordFailedDomain          = @"APINetwordFailedDomain";

NSString* kAPIConnectionStandartSuccessKey      = @"Success";
NSString* kAPIConnectionStandartDataKey         = @"Data";
NSString* kAPIConnectionStandartMessageKey      = @"Message";
NSString* kAPIConnectionStandartErrorCodeKey      = @"Code";
@interface APIConnection ()


@property(nonatomic,retain) id<NSObject>  successTarget;
@property(nonatomic,assign) SEL successSelector;
@property(nonatomic,retain) id<NSObject>  failedTarget;
@property(nonatomic,assign) SEL failedSelector;
@property(nonatomic,retain) id<NSObject>  cacheSuccessTarget;
@property(nonatomic,assign) SEL cacheSuccessSelector;


@end
@implementation APIConnection

- (id)initWithConnectionUrlString:(NSString *)requestUrl
{
    self = [super initWithURL:[NSURL URLWithString:requestUrl]]; //ASIFormDataRequest
    if (self) {
        [self enableCache];
        _requestUrl = [requestUrl copy];
        self.timeOutSeconds = 30.0f;        //设置超时时间
        _addCache = true;
    
    }
    return self;
}
- (void)dealloc
{
    [_requestUrl autorelease];
    [_params release];
    [_successTarget release];
    [_failedTarget release];
    [_cacheSuccessTarget release];
    [self connectionReleaseBlocksOnMainThread];
    [super dealloc];
}
- (void)releaseBlocks{
    Block_release(_onSuccess);
    _onSuccess = nil;
    Block_release(_onFailed);
    _onFailed = nil;
    Block_release(_onFinal);
    _onFinal = nil;
    Block_release(_onCacheSuccess);
    _onCacheSuccess = nil;
}

- (void)connectionReleaseBlocksOnMainThread{
	NSMutableArray *blocks = [NSMutableArray array];
	if (_onSuccess) {
		[blocks addObject:_onSuccess];
		[_onSuccess release];
		_onSuccess = nil;
	}
    if (_onFailed) {
		[blocks addObject:_onFailed];
		[_onFailed release];
		_onFailed = nil;
	}
    if (_onFinal) {
        [blocks addObject:_onFinal];
		[_onFinal release];
		_onFinal = nil;
    }
    if (_onCacheSuccess) {
        [blocks addObject:_onCacheSuccess];
        [_onCacheSuccess release];
		_onCacheSuccess = nil;
    }
	[[self class] performSelectorOnMainThread:@selector(releaseBlocks:) withObject:blocks waitUntilDone:[NSThread isMainThread]];
}

- (id) proccessResult:(NSString*)responseString{
    if (self.responseFormat) {
        NSString *resultString = nil;
        self.responseFormat(responseString,&resultString);
        responseString = resultString;
    }

    switch (_resultType) {
        case kAPIConnectionTypeStandart:
        case kAPIConnectionTypeJSON:{
            NSDictionary *json = apiFilterObject([responseString JSONValue]);
            if (_preproccess &&json) {
                BOOL success = 0; 
                NSString *message = NULL;
                id data = nil;
                _preproccess(json,&success,&data,&message);
                NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
                dictionary[kAPIConnectionStandartSuccessKey] = @(success);
                if (message) {
                    dictionary[kAPIConnectionStandartMessageKey] = message;
                }
                if (data) {
                    dictionary[kAPIConnectionStandartDataKey] = data;
                }
                return dictionary;
            }
            return apiFilterObject([responseString JSONValue]);
            break;
        }
        case kAPIConnectionTypePlain:
        default:
            return responseString;
            break;
    }
    return NULL;
}
- (void) setCompletionBlock:(ASIBasicBlock)aCompletionBlock{
    NSAssert(false, @"do not use this method, use setOnComplete instead");
}
- (void) setFailedBlock:(ASIBasicBlock)aFailedBlock{
    NSAssert(false, @"do not use this method, use setOnFailed instead");
}
- (void)prepareForRequest{
//    [self retain];
    
    __block typeof(self) bSelf = self;
    [super setCompletionBlock:^{
//        NSString *response = [bSelf responseString];
        NSData *data = [bSelf responseData];
        NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [bSelf onConnectionCompelte:response];
        if (!bSelf -> _isCacheLoading) {
            [bSelf releaseBlocks];        
        }
    }];
    [super setFailedBlock:^{
        if(bSelf->_onFailed) bSelf->_onFailed(bSelf->error);
        if(bSelf->_onFinal)  bSelf->_onFinal();
        [bSelf releaseBlocks];
    }];
    
    if ([[self requestMethod]isEqualToString:@"GET"]) {
        [self setURLString:_requestUrl withParams:self.params];
    }else if([[self requestMethod]isEqualToString:@"POST"]){
        [self setPostParams:self.params];
    }

}
- (void) startAsynchronous{
//    if ([[self requestMethod]isEqualToString:@"GET"] && _isFirstLoadMode) {
//        APIConnection *updateApi = [self copy];
//        if(_firstLoadDontCall) [updateApi releaseBlocks];
//        updateApi .isFirstLoadMode = false;
//        [updateApi startAsynchronous];
//        [updateApi autorelease];
//        [self setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
//        [self prepareForRequest];
//        [super startAsynchronous];
//    }else{
        [self prepareForRequest];
        [super startAsynchronous];
//    }
    _isCacheLoading = false;

    LSInfo(@"%@",self.url);

}
- (void) startSynchronous{
//    if ([[self requestMethod]isEqualToString:@"GET"] && _isFirstLoadMode) {
//        APIConnection *updateApi = [self copy];
//        if(_firstLoadDontCall) [updateApi releaseBlocks];
//        updateApi .isFirstLoadMode = false;
//        [updateApi startSynchronous];
//        [updateApi autorelease];
//        [self setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
//        [self prepareForRequest];
//        [super startSynchronous];
//    }else{
        [self prepareForRequest];
        [super startSynchronous];
//    }
    _isCacheLoading = false;
    LSInfo(@"%@",self.url);
}

- (void)setSuccessTarget:(id)target selector:(SEL)selector{
    self.successTarget = target;
    _successSelector = selector;
}

- (void)setFailedTarget:(id)target selector:(SEL)selector{
    self.failedTarget = target;
    _failedSelector = selector;
}
- (void)    setCacheSuccessTarget:(id)target selector:(SEL)selector{
    self.cacheSuccessTarget = target;
    _cacheSuccessSelector = selector;
}
- (void)onConnectionCompelte:(NSString *)responseString{
//    NSData *data = [self postBody];
//    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    id result = [self proccessResult:responseString];
    if (!result) {
        if (STRING_NOT_EMPTY(responseString)) {
            NSError *anError = [[NSError alloc]initWithDomain:DhServerOperationFailedDomain code:2 userInfo:@{
                                                                                                              NSLocalizedDescriptionKey : responseString
                                                                                                                  //NSLocalizedString(@"服务器发生错误，请稍后再试", @"The server encountered an exception. Please try again later.") 
                                                                                                              }];
            if(self->_onFailed) self->_onFailed(anError);
            if(self->_onFinal) self->_onFinal();
            if ([_failedTarget respondsToSelector:_failedSelector]) {
                [_failedTarget performSelector:_failedSelector withObject:anError];
            }
            [anError autorelease];
        }else{
            NSError *nullError = [[NSError alloc]initWithDomain:APINetwordFailedDomain code:1 userInfo:@{
                                                                                                         NSLocalizedDescriptionKey : responseString
                                                                                                             //NSLocalizedString(@"服务器发生错误，请稍后再试", @"The server encountered an exception. Please try again later.") 
                                                                                                         }];
            if (self->_onFailed) self->_onFailed(nullError);
            if(self->_onFinal) self->_onFinal();
            if ([_failedTarget respondsToSelector:_failedSelector]) {
                [_failedTarget performSelector:_failedSelector withObject:nullError];
            }
            [nullError release];
        }
    }else{
        [self _connectionCompleteWithResponse:responseString andProccessedResult:result];
    }

}
- (void)_connectionCompleteWithResponse:(NSString *)responseString andProccessedResult:(id)result{
    if (self->_resultType == kAPIConnectionTypeStandart || self.preproccess) {
        result = LS_CAST(NSDictionary *, result);
        if ([result[kAPIConnectionStandartSuccessKey] boolValue]) {
            if (_isCacheLoading) {
                if (self.onCacheSuccess) {
                    self.onCacheSuccess(result);
                }else if(self->_onSuccess) {
                    self->_onSuccess(result);
                }
                if ([_cacheSuccessTarget respondsToSelector:_cacheSuccessSelector]) {
                    [_cacheSuccessTarget performSelector:_cacheSuccessSelector withObject:result];
                }else if ([_successTarget respondsToSelector:_successSelector]) {
                    [_successTarget performSelector:_successSelector withObject:result];
                }
            }else{
                if(self->_onSuccess) {
                    self->_onSuccess(result);
                }
                
                if ([_successTarget respondsToSelector:_successSelector]) {
                    [_successTarget performSelector:_successSelector withObject:result];
                }
                
                if (_addCache) {
                    if ([self.requestMethod isEqualToString:@"POST"]) {
                        [APIConnection addCache:responseString forPostWithUrl:_requestUrl andParams:self.params];
                    }else{
                        [APIConnection addCache:responseString forGetWithUrl:_requestUrl  andParams:self.params];
                    }
                }
                if(self->_onFinal) self->_onFinal();
            }
        }else{
            int code = 0;
            if (result[kAPIConnectionStandartErrorCodeKey]) {
                code= [result[kAPIConnectionStandartErrorCodeKey] integerValue];
            }
            NSError *anError = [[NSError alloc]initWithDomain:DhServerOperationFailedDomain 
                                                         code:code 
                                                     userInfo:@{NSLocalizedDescriptionKey : result[kAPIConnectionStandartMessageKey]}
                                ];
            
            if ([_failedTarget respondsToSelector:_failedSelector]) {
                [_failedTarget performSelector:_failedSelector withObject:anError];
            }
            if(self->_onFailed) self->_onFailed(anError);
            if(self->_onFinal) self->_onFinal();
            [anError autorelease];
        }
    }else{
        if (_isCacheLoading) {
            if (self.onCacheSuccess) {
                self.onCacheSuccess(result);
            }
        }else{
            if(self->_onSuccess) self->_onSuccess(result);
            if ([_successTarget respondsToSelector:_successSelector]) {
                [_successTarget performSelector:_successSelector withObject:result];
            }
            if (_addCache) {
                if ([self.requestMethod isEqualToString:@"POST"]) {
                    [APIConnection addCache:responseString forPostWithUrl:_requestUrl andParams:self.params];
                }else{
                    [APIConnection addCache:responseString forGetWithUrl:_requestUrl  andParams:self.params];
                }
            }

            if(self->_onFinal) self->_onFinal();
        }
    }
}

- (void)cancel{
    [super cancel];
    if(![self complete]){
//        [self autorelease];
    }
    [self releaseBlocks];
}

//- (void)    enableFirstLoadMode{
//    self.isFirstLoadMode = true;
//}
//- (void)    disableFirstLoadMode{
//    self.isFirstLoadMode = false;
//}

- (void)    loadFromCache{
    _isCacheLoading = true;
    id result;
    if ([self.requestMethod isEqualToString:@"POST"]) {
        result = [APIConnection cacheForPostWithUrl:_requestUrl andParams:self.params];
    }else{
        result = [APIConnection cacheForGetWithUrl:_requestUrl  andParams:self.params];
    }
    if (result){
        @try {
            [self onConnectionCompelte:result];
        }
        @catch (NSException *exception) {
            
        }
    }
    _isCacheLoading = false;
}
- (void)    enableCache{
    [self setDownloadCache:[ASIDownloadCache sharedCache]];     
    [self setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];  
    [self setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];            
    [[ASIDownloadCache sharedCache] setShouldRespectCacheControlHeaders:NO];   
}

- (void)    disableCache{
    [self setDownloadCache:NULL];
    [[ASIDownloadCache sharedCache] setShouldRespectCacheControlHeaders:YES];
}

- (void)    setURLString:(NSString *)urlString{
    [self setURL:[NSURL URLWithString:urlString]];
}
+ (NSString *)urlString:(NSString *)urlString withParams:(NSDictionary *)params{
    __block NSMutableString    *paramsString = [[[NSMutableString alloc]initWithCapacity:1024] autorelease];
    __block BOOL                isFirst = true;
    if (params) {
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if (![obj isKindOfClass:[NSArray class]]) {
                obj = @[obj];
            }
            if([obj isKindOfClass:[NSArray class]]){
                for (NSString* string in obj ) {
                    if ([string isKindOfClass:[NSNumber class]]) {
                        string = [LS_CAST(NSNumber *, string) stringValue];
                    }
                    string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    if (string .length == 0) return ;
                    if (isFirst) {
                        isFirst = false;
                        [paramsString appendFormat:@"%@=%@" ,key ,string];
                    }  else [paramsString appendFormat:@"&%@=%@" ,key ,string ];
                    
                }
            }
        }];
    }
    //Added by lessu 2013 11 25
    if([urlString rangeOfString:@"?"].length == 0){
        return STRING_FORMAT(@"%@%@%@", urlString,paramsString.length>0?@"?":@"",paramsString);
    }else{
        return STRING_FORMAT(@"%@%@%@", urlString,paramsString.length>0?@"&":@"",paramsString);
    }

}
- (void)    setURLString:(NSString *)urlString withParams:(NSDictionary *)params{
    [self setURLString:[APIConnection urlString:urlString withParams:params]];
    return ;
    __block NSMutableString    *paramsString = [[[NSMutableString alloc]initWithCapacity:1024] autorelease];
    __block BOOL                isFirst = true;
    if (params) {
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if (![obj isKindOfClass:[NSArray class]]) {
                obj = @[obj];
            }
            if([obj isKindOfClass:[NSArray class]]){
                for (NSString* string in obj ) {
                    if ([string isKindOfClass:[NSNumber class]]) {
                        string = [LS_CAST(NSNumber *, string) stringValue];
                    }
                    string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    if (string .length == 0) return ;
                    if (isFirst) {
                        isFirst = false;
                        [paramsString appendFormat:@"%@=%@" ,key ,string];
                    }  else [paramsString appendFormat:@"&%@=%@" ,key ,string ];
                    
                }
            }
        }];
    }
    //Added by lessu 2013 11 25
    if([urlString rangeOfString:@"?"].length == 0){
        [self setURLString:STRING_FORMAT(@"%@%@%@", urlString,paramsString.length>0?@"?":@"",paramsString)];
    }else{
        [self setURLString:STRING_FORMAT(@"%@%@%@", urlString,paramsString.length>0?@"&":@"",paramsString)];
    }
}

- (void)    setPostParams:(NSDictionary *)params{
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSString class]]||[obj isKindOfClass:[NSNumber class]]) {
            [self addPostValue:obj forKey:key];
        }else if([obj isKindOfClass:[NSArray class]]){
            for (NSString* string in obj ) {
                [self addPostValue:obj forKey:key];
            }
        }else{
            [self addPostValue:obj forKey:key];
        }
    }];
}

- (id)copyWithZone:(NSZone *)zone{
    APIConnection *copyed = [super copyWithZone:zone];
    copyed .onSuccess = self.onSuccess;
    copyed .onFailed  = self.onFailed;
    copyed .onFinal   = self.onFinal;
    copyed .onCacheSuccess=self.onCacheSuccess;
    copyed .resultType = self.resultType;
    copyed .params     = self.params;
//    copyed .isFirstLoadMode = self .isFirstLoadMode;
    copyed .requestUrl = self .requestUrl;
    return copyed;
}

@end

id           apiFilterObject(id object){
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = object;
        NSMutableDictionary *resultDictionary = [NSMutableDictionary dictionary];
        [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            resultDictionary[key] = apiFilterObject(obj);
        }];
        return resultDictionary;
    }else if([object isKindOfClass:[NSArray class]]){
        NSArray *array = object;
        NSMutableArray *resultArray = [NSMutableArray array];
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [resultArray addObject:apiFilterObject(obj)];
        }];
        return resultArray;
    }else if([object isKindOfClass:[NSNumber class]]){
        return [NSString stringWithFormat:@"%@",object];
    }else if(object == [NSNull null]){
        return @"";
    }else{
        return object;
    }
}
