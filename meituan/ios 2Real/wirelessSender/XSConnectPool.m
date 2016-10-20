//
//  XSConnectPool.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/19.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSConnectPool.h"
#import "OpenUDID.h"
#import "KeychainItemWrapper.h"

@implementation XSConnectPool
+ (XSConnectPool *)shareInstance{
    static dispatch_once_t onceToken;
    static XSConnectPool *connectPool;
    dispatch_once(&onceToken, ^{
        connectPool = [[XSConnectPool alloc] init];
    });
    return connectPool;
}
- (NSString *) getUuid{
    KeychainItemWrapper *warpper = [[KeychainItemWrapper alloc] initWithIdentifier:@"uuid" accessGroup:@"com.j1.wireless"];
    NSString *openudid = [warpper objectForKey:(__bridge id) kSecValueData];
    if( !openudid || ![openudid isKindOfClass:[NSString class]] ) {
        openudid = [OpenUDID value];
        [warpper setObject:openudid forKey:(__bridge id) kSecValueData];
    }
    return openudid;
}
@end
