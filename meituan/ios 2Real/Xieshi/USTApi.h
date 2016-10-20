//
//  USTApi.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-28.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "API.h"
#import "NSObject+SBJSON.h"


#define APIMETHOD_UST_AuditedList       @"APIMETHOD_UST_AuditedList"
#define APIMETHOD_UST_ExamedList        @"APIMETHOD_UST_ExamedList"
#define APIMETHOD_UST_ExamList          @"APIMETHOD_UST_ExamList"
#define APIMETHOD_UST_AuditList         @"APIMETHOD_UST_AuditList"
#define APIMETHOD_UST_ExamList          @"APIMETHOD_UST_ExamList"
#define APIMETHOD_UST_AuditedExamedItem   @"APIMETHOD_UST_AuditedExamedItem"
#define APIMETHOD_UST_AuditedExamedKind     @"APIMETHOD_UST_AuditedExamedKind"
#define APIMETHOD_UST_Exam              @"APIMETHOD_UST_Exam"
#define APIMETHOD_UST_Audit             @"APIMETHOD_UST_Audit"
#define APIMETHOD_UST_UserLogin         @"APIMETHOD_UST_UserLogin"
#define APIMETHOD_UST_BindStart         @"APIMETHOD_UST_BindStart"
#define APIMETHOD_UST_BindEnd           @"APIMETHOD_UST_BindEnd"
#define APIMETHOD_UST_UnBind            @"APIMETHOD_UST_UnBind"
#define APIMETHOD_UST_SearchYanZhengMa  @"APIMETHOD_UST_SearchYanZhengMa"
#define APIMETHOD_UST_ChangePassWord    @"APIMETHOD_UST_ChangePassWord"
#define APIMETHOD_UST_AppAuditedList    @"APIMETHOD_UST_AppAuditedList"
#define  APIMETHOD_UST_GetUpdateVersion @"APIMETHOD_UST_GetUpdateVersion"
@interface USTApi : API
SHARED_INSTANCE_INTERFACE(USTApi);
@end
