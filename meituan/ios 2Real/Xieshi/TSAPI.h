//
//  TSAPI.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-1-7.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "API.h"
#import "NSObject+SBJSON.h"
#define APIMETHOD_TS_TODAY @"APIMETHOD_TS_TODAY"
#define APIMETHOD_TS_TODAY_MANAGE_UNIT @"APIMETHOD_TS_TODAY_MANAGE_UNIT"
#define APIMETHOD_TS_TODAY_MANAGE_UNIT_DETAIL @"APIMETHOD_TS_TODAY_MANAGE_UNIT_DETAIL"
@interface TSAPI : API

SHARED_INSTANCE_INTERFACE(TSAPI);

@end
