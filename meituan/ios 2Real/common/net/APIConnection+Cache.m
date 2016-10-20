//
//  APIConnection+Cache.m
//  Yingcheng
//
//  Created by lessu on 14-3-3.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "APIConnection+Cache.h"
#import "LSCacheManager.h"
#import "LSCommonCrypto.h"
@implementation APIConnection (Cache)

+ (void)addCache:(id)cache forGetWithUrl:(NSString *)url andParams:(NSDictionary *)params{
    NSString *urlString = STRING_FORMAT(@"GET:%@", [self urlString:url withParams:params]);
    NSString *md5 = [LSCommonCrypto md5:urlString];
    [[LSCacheManager sharedInstance] addCache:cache hashCode:md5 expire:15*60];

}
+ (void)addCache:(id)cache forPostWithUrl:(NSString *)url andParams:(NSDictionary *)params{
    NSString *urlString = STRING_FORMAT(@"POST:%@", [self urlString:url withParams:params]);
    NSString *md5 = [LSCommonCrypto md5:urlString];

    [[LSCacheManager sharedInstance] addCache:cache hashCode:md5 expire:15*60];
}
+ (id)cacheForGetWithUrl:(NSString *)url andParams:(NSDictionary *)params{
    NSString *urlString = STRING_FORMAT(@"GET:%@", [self urlString:url withParams:params]);
    NSString *md5 = [LSCommonCrypto md5:urlString];

    return [[LSCacheManager sharedInstance] cache:md5 ignoreExpire:YES];
}

+ (id)cacheForPostWithUrl:(NSString *)url andParams:(NSDictionary *)params{
    NSString *urlString = STRING_FORMAT(@"POST:%@", [self urlString:url withParams:params]);
    NSString *md5 = [LSCommonCrypto md5:urlString];

    return [[LSCacheManager sharedInstance] cache:md5 ignoreExpire:YES];
}

@end
