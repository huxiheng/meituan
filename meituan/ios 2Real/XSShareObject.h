//
//  XSShareObject.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/18.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYAdapterIPManager.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface XSShareObject : NSObject
/**
 *  创建当前类的一个单例
 *  @return
 */
+ (instancetype)sharedInstance;

///判断手机号码是否合法
+(BOOL) isValidateMobile:(NSString *)mobile;

///去除手机号+86
+(NSString *)formatPhoneNum:(NSString *)phone;

/**
 *  域名解析
 *
 *  @param webSiteString 字母域名
 *
 *  @return 纯数字的域名
 */
+(NSString *)DNSAnalyse:(NSString *)webSiteString;
@end
