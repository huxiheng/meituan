//
//  HYAdapter.h
//  Wireless_Sender
//
//  Created by zhizi on 16/5/26.
//  Copyright © 2016年 j1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYAdapterIPManager : NSObject
+ (HYAdapterIPManager *)shareAdapterIPManager;
- (BOOL)currentNetworkTypeIsIPV4;
- (NSString *)DNSV6Analyse:(NSString *)webSiteString;

@end
