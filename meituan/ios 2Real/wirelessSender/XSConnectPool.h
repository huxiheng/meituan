//
//  XSConnectPool.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/19.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSConnectPool : NSObject

+ (XSConnectPool *)shareInstance;
- (NSString *) getUuid;

@end
