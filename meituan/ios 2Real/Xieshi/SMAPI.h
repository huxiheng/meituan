//
//  SMAPI.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-1-7.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "API.h"
#define APIMETHOD_SM_ConsignList        @"APIMETHOD_SM_ConsignList"
#define APIMETHOD_SM_ProjectList        @"APIMETHOD_SM_ProjectList"
#define APIMETHOD_SM_SampleDetail       @"APIMETHOD_SM_SampleDetail"
#define APIMETHOD_SM_SampleInfoByCode   @"APIMETHOD_SM_SampleInfoByCode"
#define APIMETHOD_SM_SampleList         @"APIMETHOD_SM_SampleList"
@interface SMAPI : API
SHARED_INSTANCE_INTERFACE(SMAPI);

@end
