//
//  LSCacheManager.h
//  SeeCollection
//
//  Created by Lessu on 13-2-28.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSCacheManager : NSObject
{
    NSMutableData   *_cacheData;
    NSKeyedArchiver *_cacheArchiver;
    
    NSString        *_cacheDataPath;
    NSString        *_cacheExpireDataFilePath;
    
    
    NSMutableDictionary    *_expireDictionary;
}
@property(nonatomic ,assign) BOOL usingCache;

+ (LSCacheManager *) sharedInstance;

/**------------------------------------------------------
 *                       LSCacheManager
 *                       Basic Method
 *
 *------------------------------------------------------*/
- (BOOL)hasCache:(NSString *)hash ignoreExpire:(BOOL) ignoreExpire;
- (id)  cache:(NSString *)hash ignoreExpire:(BOOL) ignoreExpire;
- (void)addCache:(id)data hashCode:(NSString *)hash expire:(int)second;


- (BOOL)cacheFileExists:(NSString *)filepath;

- (BOOL)clearCaches;

//- (void)cleanExpiredCache;
//- (void)removeCacheForHash:(NSString *)hash;
@end
