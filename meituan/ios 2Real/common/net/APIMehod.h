//
//  APIMehod.h
//  Youxian100
//
//  Created by Lessu on 13-3-29.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#ifndef Youxian100_APIMehod_h
#define Youxian100_APIMehod_h


#define API_TRUE            @"1"
#define API_FALSE           @"0"

//setting
#define API_URL             @"API_URL"
#define API_CACHE           @"API_CACHE"
#define API_CACHE_ENABLE    @"API_CACHE_ENABLE"
#define API_CONNECT_METHOD  @"API_CONNECT_METHOD"

#define API_RESULT_TYPE     @"API_RESULT_TYPE"
#define API_CONNECT_METHOD_GET  @"GET"
#define API_CONNECT_METHOD_POST @"POST"
#define API_CONNECT_METHOD_SOAP @"SOAP"
#define API_SOAP_ACTION     @"API_SOAP_ACTION"
#define API_FIRSTLOAD_ENABLE @"API_FIRSTLOAD_ENABLE"
#define API_FIRSTLOAD_DONT_CALL @"API_FIRSTLOAD_DONT_CALL"
//#define API_RESULT_TYPE     @"API_RESULT_TYPE"
//#define API_
//Cache
// The default cache policy. When you set a request to use this, it will use the cache's defaultCachePolicy
// ASIDownloadCache's default cache policy is 'ASIAskServerIfModifiedWhenStaleCachePolicy'
#define APICACHE_DEFAULT                        ASIUseDefaultCachePolicy
// Tell the request not to read from the cache
#define APICACHE_DONOT_READ_FROM_CACHE          ASIDoNotReadFromCacheCachePolicy
// The the request not to write to the cache
#define APICACHE_DONOT_WRITE_TO_CACHE           ASIDoNotWriteToCacheCachePolicy
/**
 *  默认缓存策略  优先使用缓存，缓存过期才访问网络.
 */
// Ask the server if there is an updated version of this resource (using a conditional GET) ONLY when the cached data is stale
#define APICACHE_AUTO                           ASIAskServerIfModifiedWhenStaleCachePolicy 

/**
 *  优先使用网络检查新数据，也就是得到的永远是最新的。
 */
// Always ask the server if there is an updated version of this resource (using a conditional GET)

#define APICACHE_SERVER_IF_MODIFIED             ASIAskServerIfModifiedCachePolicy
/**
 *  优先使用缓存
 */
// If cached data exists, use it even if it is stale. This means requests will not talk to the server unless the resource they are requesting is not in the cache
#define APICACHE_USE_CACHED                     ASIOnlyLoadIfNotCachedCachePolicy 
/**
 *  只使用缓存
 */
// If cached data exists, use it even if it is stale. If cached data does not exist, stop (will not set an error on the request)
#define APICACHE_DONOT_USE                      ASIDontLoadCachePolicy                
/**
 *  优先使用网络
 */
// Specifies that cached data may be used if the request fails. If cached data is used, the request will succeed without error. Usually used in combination with other options above.
#define APICACHE_USE_IF_FAILED                  ASIFallbackToCacheIfLoadFailsCachePolicy

#endif





