//
//  LSDevice.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-28.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "LSDevice.h"
#import "LSUtil.h"
#import "KeychainItemWrapper.h"
#import <Security/Security.h>
NSString * const LSDeviceUUIDKey = @"ls_device_uuid";
@implementation LSDevice
+ (NSString*) uuid {

        
        KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc]
                                             initWithIdentifier:@"Device_UUID"
                                             accessGroup:@"G339UR276R.comz.yoursjoy.dev.xsPrivate"];
                                                            
        NSString *strUUID = [keychainItem objectForKey:(__bridge id)kSecAttrService];
        if (strUUID == nil || [strUUID isEqualToString:@""])
        {
            CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
            strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
            [keychainItem resetKeychainItem];
            [keychainItem setObject:strUUID forKey:(__bridge id)kSecAttrService];
        }

    return strUUID;
}
@end
