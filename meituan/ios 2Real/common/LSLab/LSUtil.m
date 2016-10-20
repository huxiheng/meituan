//
//  YFUtil.m
//  Yingfeng
//
//  Created by Lessu on 13-7-24.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSUtil.h"
@interface LSUtil()

@end
NSString *currentUser;
@implementation LSUtil
//SHARED_INSTANCE_IMPLEMENT(LSUtil, sharedUtil, );
+ (void)setCurrentUserId:(NSString *)user{
    currentUser = [user copy];
}

+ (NSString *)currentUserId{
    return currentUser;
}

+ (BOOL)isLogin{
    return [LSUtil currentUserId]!=0;
}

+ (void)logout{
    [LSUtil setCurrentUserId:nil];
    [ASIHTTPRequest clearSession];
}
+ (id)valueForKey:(NSString *)key{
    NSMutableDictionary *userDefaults;
    userDefaults = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"yingfeng_setting"] mutableCopy] autorelease];
    return userDefaults[key];
}

+ (void)setValue:(id) obj forKey:(NSString *)key{
    NSUserDefaults *userStandart = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *setting = [[[userStandart objectForKey:@"yingfeng_setting"] mutableCopy]autorelease];
    if (!setting) {
        setting = [NSMutableDictionary dictionary];
    }
    if (obj == NULL) {
        [setting removeObjectForKey:key];
    }else{
        setting[key] = obj;
    }
    [userStandart setValue:setting forKey:@"yingfeng_setting"];
    [userStandart synchronize];
}

- (id)valueForKey:(NSString *)key{
    NSMutableDictionary *userDefaults;
    
    NSUserDefaults *userStandart = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *setting = [[[userStandart objectForKey:@"yingfeng_setting"] mutableCopy]autorelease];
    NSString *userId;
    if (currentUser) {
        userId = currentUser;
    }else{
        userId = @"0";
    }
    userDefaults =  [[setting[userId]  mutableCopy ] autorelease];
    return userDefaults[key];
}

- (void)setValue:(id) obj forKey:(NSString *)key{
    NSMutableDictionary *userDefaults;
    
    NSUserDefaults *userStandart = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *setting = [[[userStandart objectForKey:@"yingfeng_setting"] mutableCopy]autorelease];
    if (!setting) {
        setting = [NSMutableDictionary dictionary];
    }
    NSString *userId;
    if (currentUser) {
        userId = currentUser;
    }else{
        userId = @"0";
    }
    userDefaults =  [[setting[userId]  mutableCopy ] autorelease];

    if (!userDefaults) {
        userDefaults = [NSMutableDictionary dictionary];
    }
    if (obj) {
        userDefaults[key] = obj;
    }else{
        [userDefaults removeObjectForKey:key];
    }
    
    setting[userId] = userDefaults;
    [userStandart setValue:setting forKey:@"yingfeng_setting"];
    [userStandart synchronize];
}


@end
