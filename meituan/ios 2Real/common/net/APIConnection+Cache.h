//
//  APIConnection+Cache.h
//  Yingcheng
//
//  Created by lessu on 14-3-3.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "APIConnection.h"
typedef enum{
    APIConnectionCacheConnectionMethodAny = 0,
    APIConnectionCacheConnectionMethodGet,
    APIConnectionCacheConnectionMethodPost,
    
}APIConnectionCacheConnectionMethod;

@interface APIConnection (Cache)

+ (void)addCache:(id)cache forGetWithUrl:(NSString *)url andParams:(NSDictionary *)params;
+ (void)addCache:(id)cache forPostWithUrl:(NSString *)url andParams:(NSDictionary *)params;

+ (id)cacheForGetWithUrl:(NSString *)url andParams:(NSDictionary *)params;
+ (id)cacheForPostWithUrl:(NSString *)url andParams:(NSDictionary *)params;

@end
