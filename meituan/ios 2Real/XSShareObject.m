//
//  XSShareObject.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/18.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSShareObject.h"
#include <netdb.h>
#import <arpa/inet.h>

static XSShareObject   *shareObject;

@implementation XSShareObject
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        shareObject = [[XSShareObject alloc] init];
    });
    return shareObject;
}

/*手机号码验证 MODIFIED BY HELENSONG*/
+(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13，15，18开头，八个 \d 数字字符
    //    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString *phoneRegex = @"^[1][0-9]{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

///去除手机号+86
+(NSString *)formatPhoneNum:(NSString *)phone
{
    if ([phone hasPrefix:@"86"]) {
        NSString *formatStr = [phone substringWithRange:NSMakeRange(2, [phone length]-2)];
        return formatStr;
    }
    else if ([phone hasPrefix:@"+86"])
    {
        if ([phone hasPrefix:@"+86·"]) {
            NSString *formatStr = [phone substringWithRange:NSMakeRange(4, [phone length]-4)];
            return formatStr;
        }
        else
        {
            NSString *formatStr = [phone substringWithRange:NSMakeRange(3, [phone length]-3)];
            return formatStr;
        }
    }
    return phone;
}

///域名解析,传入域名如：www.baidu.com，返回 61.135.169.105
+(NSString *)DNSAnalyse:(NSString *)webSiteString
{
    if( [webSiteString rangeOfString:@":"].location != NSNotFound ) {
        return nil;
    }
    
    if ([[HYAdapterIPManager shareAdapterIPManager] currentNetworkTypeIsIPV4]) {
        const char *webSite = [webSiteString cStringUsingEncoding:NSASCIIStringEncoding];
        struct hostent *remoteHostEnt = gethostbyname(webSite);
        if (remoteHostEnt == NULL) {
            NSLog(@"不正确的域名或当前网络未连接");
            return nil;
        }
        struct in_addr *remoteInAddr = (struct in_addr *)remoteHostEnt->h_addr_list[0];
        char *sRemoteInAddr = inet_ntoa(*remoteInAddr);
        NSLog(@"DNS Address: %s for : %@", sRemoteInAddr, webSiteString);
        NSString *ip = [[NSString alloc] initWithCString:sRemoteInAddr encoding:NSASCIIStringEncoding];
        return ip;
    }
    return [[HYAdapterIPManager shareAdapterIPManager] DNSV6Analyse:webSiteString];
}

@end
