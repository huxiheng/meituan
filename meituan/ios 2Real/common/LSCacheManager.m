//
//  LSCacheManager.m
//  SeeCollection
//
//  Created by Lessu on 13-2-28.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSCacheManager.h"

@implementation LSCacheManager
+ (LSCacheManager *) sharedInstance{
    static LSCacheManager *sharedInstance;
    if(sharedInstance == 0){
        sharedInstance = [[LSCacheManager alloc]init];
        
    }
    return sharedInstance;
}
- (id)init
{
    self = [super init];
    if (self) {
        _cacheDataPath = @"_LSCache";
        _cacheExpireDataFilePath = @".__LSCacheExpire__";

        NSString *cacheDir =[self cacheDir];
        if (![[NSFileManager defaultManager]fileExistsAtPath:cacheDir]) {
            if (![[NSFileManager defaultManager]createDirectoryAtPath:cacheDir withIntermediateDirectories:NO attributes:0 error:0]){
                NSLog(@"%@,%@",@"ERROR: LSCacheManeger create cache dir failed.",cacheDir);
            }
        }
        if (![self fileExists:[self cachePath:_cacheExpireDataFilePath]]) {
            NSMutableData *data = [[NSMutableData alloc]init];
            NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
            [archiver encodeObject:@{}];
            [archiver finishEncoding];
            LS_RELEASE_SAFELY(archiver);
            BOOL success = [data writeToFile:[self cachePath:_cacheExpireDataFilePath] atomically:YES];
            LS_RELEASE_SAFELY(data);
            if (!success) {
                NSLog(@"%@",@"ERROR: LSCacheManager write expire file failed!");
                return self;
            }
        }
        NSData *data  = [NSData dataWithContentsOfFile:[self cachePath:_cacheExpireDataFilePath]];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        _expireDictionary = [[unarchiver decodeObject] mutableCopy];
        [unarchiver finishDecoding];
        LS_RELEASE_SAFELY(unarchiver);
    }
    return self;
}
- (void)dealloc
{
    LS_RELEASE_SAFELY(_expireDictionary);
    [super dealloc];
}
-(BOOL)hasCache:(NSString *)hash ignoreExpire:(BOOL) ignoreExpire{
    return [self fileExists:[self cachePath:hash]] && (ignoreExpire || ![self isExpired:[self cachePath:hash]]);
}
- (id)cache:(NSString *)hash ignoreExpire:(BOOL)ignoreExpire{
    if([self hasCache:hash ignoreExpire:ignoreExpire]){
        NSData *data = [NSData dataWithContentsOfFile:[self cachePath:hash]];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        id returnObject =  [unarchiver decodeObject];
        [unarchiver finishDecoding];
        LS_RELEASE_SAFELY(unarchiver);
        return returnObject;
    }
    return NULL;
}
- (void)addCache:(id)object hashCode:(NSString *)hash expire:(int)second{
    NSMutableData *data = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:object];
    [archiver finishEncoding];
    LS_RELEASE_SAFELY(archiver);
    BOOL success = [data writeToFile:[self cachePath:hash] atomically:YES];

    LS_RELEASE_SAFELY(data);
    
    if (!success) {
        NSLog(@"%@,path:%@",@"ERROR:LSCacheManager write cache file failed",[self cachePath:hash]);
        return;
    }
    
    NSDate *now = [[[NSDate alloc]init] autorelease];
    NSTimeInterval nowTimeInterval= [now timeIntervalSince1970];
    _expireDictionary[hash] = [NSString stringWithFormat:@"%ld", (long) (nowTimeInterval + second)];
    
    data = [[NSMutableData alloc]init];
    archiver =  [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:_expireDictionary];
    [archiver finishEncoding];
    LS_RELEASE_SAFELY(archiver);
    success = [data writeToFile:[self cachePath:_cacheExpireDataFilePath] atomically:YES];
    LS_RELEASE_SAFELY(data);
    if (!success) {
        NSLog(@"%@",@"ERROR:LSCacheManager write cache file expire!");
    }
}
//- (void)removeCacheForHash:(NSString *)hash{
//    NSString *filePath = [self getCachePath:hash];
//    [[NSFileManager defaultManager]removeItemAtPath:filePath error:0];
//}
//- (void)cleanExpiredCache{
//    
//    
//}



- (NSString *)cacheDir{
    NSString *tempPath = NSTemporaryDirectory();
    return [tempPath stringByAppendingPathComponent:_cacheDataPath];
}
- (NSString *)cachePath:(NSString*)key{
    NSString *tempPath = NSTemporaryDirectory();
    return [[tempPath stringByAppendingPathComponent:_cacheDataPath] stringByAppendingPathComponent:key];
}
- (BOOL)fileExists:(NSString *)filepath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filepath];
}
- (BOOL)isExpired:(NSString *) filepath{
    if ([self fileExists:filepath] && _expireDictionary[filepath] && _expireDictionary[filepath] != [NSNull null]) {
        int exp = [_expireDictionary[filepath] longValue];
        NSDate *now = [[[NSDate alloc]init] autorelease];
        NSTimeInterval nowTimeInterval= [now timeIntervalSince1970];
        return nowTimeInterval > exp;
    }else return NO;
}
- (BOOL)cacheFileExists:(NSString *)filepath{
    
    return [self fileExists:[self cachePath:filepath]];
}
- (BOOL)clearCaches{
    NSString *cacheDir =[self cacheDir];
    if( [[NSFileManager defaultManager]removeItemAtPath:cacheDir error:0] ){
        NSString *cacheDir =[self cacheDir];
        if (![[NSFileManager defaultManager]fileExistsAtPath:cacheDir]) {
            if (![[NSFileManager defaultManager]createDirectoryAtPath:cacheDir withIntermediateDirectories:NO attributes:0 error:0]){
                NSLog(@"%@,%@",@"ERROR: LSCacheManeger create cache dir failed.",cacheDir);
                return NO;
            }
        }
        if (![self fileExists:[self cachePath:_cacheExpireDataFilePath]]) {
            NSMutableData *data = [[NSMutableData alloc]init];
            BOOL success = [data writeToFile:[self cachePath:_cacheExpireDataFilePath] atomically:YES];
            LS_RELEASE_SAFELY(data);
            if (!success) {
                NSLog(@"%@",@"ERROR: LSCacheManager write expire file failed!");
                return NO;
            }
        }
        return YES;
    }else{
        NSLog(@"%@",@"ERROR: LSCacheManager clear cache failed");
        return NO;
    }
}

@end
/*

#import <Foundation/Foundation.h>


@interface CacheHelper : NSObject {
    
}

+ (void) setObject:(NSData *) data forKey:(NSString *) key withExpires:(int) expires;
+ (NSData *) get:(NSString *) key;
+ (void) clear;
+ (NSString *)getTempPath:(NSString*)key;
+ (BOOL)fileExists:(NSString *)filepath;
+ (BOOL)isExpired:(NSString *) key;

@end
#import "CacheHelper.h"
@implementation CacheHelper

+ (void) setObject:(NSData *) data forKey:(NSString *) key withExpires:(int) expires{
    NSDate *dt = [NSDate date];
    double now = [dt timeIntervalSince1970];
    NSMutableString *expiresString = [[NSMutableString alloc] init];
    NSData *dataExpires = [[expiresString stringByAppendingFormat:@"%f",now+expires] dataUsingEncoding:NSUTF8StringEncoding];
    [expiresString release];
    //创建缓存时间控制文件
    [dataExpires writeToFile:[[self getTempPath:key] stringByAppendingFormat:@"%@",@".expires"] atomically:NO];
    //创建缓存文件，写入缓存
    [data writeToFile:[self getTempPath:key] atomically:NO];
}

+ (NSData *) get:(NSString *) key{
    if(![self fileExists:[self getTempPath:key]] || [self isExpired:[self getTempPath:key]]){
        NSLog(@"no cache");
        return nil;
    }
    
    NSData *data = [NSData dataWithContentsOfFile:[self getTempPath:key]];
    return data;
}

+ (void) clear{
    
}
//获取临时文件目录
+ (NSString *)getTempPath:(NSString*)key{
    NSString *tempPath = NSTemporaryDirectory();
    return [tempPath stringByAppendingPathComponent:key];
}
//判断文件是否存在
+ (BOOL)fileExists:(NSString *)filepath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filepath];
}

//判断是否过期
+ (BOOL)isExpired:(NSString *) filepath{
    NSData *data = [NSData dataWithContentsOfFile:[filepath stringByAppendingFormat:@"%@",@".expires"]];
    NSString *expires = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
    double exp = [expires doubleValue];
    [expires release];
    NSDate *dt = [NSDate date];
    double value = [dt timeIntervalSince1970];
    
    if(exp > value){
        
        return NO;
    }
    return YES;
}

@end
*/