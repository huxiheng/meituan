//
//  CommonAPI.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-1-8.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "API.h"
#define APIMETHOD_BHGItemSource     @"APIMETHOD_BHGItemSource"
#define APIMETHOD_ItemKindSource    @"APIMETHOD_ItemKindSource"
#define APIMETHOD_ItemItemSource    @"APIMETHOD_ItemItemSource"

#define APIMETHOD_UQ_ReportList     @"APIMETHOD_UQ_ReportList"
#define APIMETHOD_UQ_ReportDetail   @"APIMETHOD_UQ_ReportDetail"
#define APIMETHOD_UQ_SampleList     @"APIMETHOD_UQ_SampleList"
#define APIMETHOD_UQ_SampleDetail   @"APIMETHOD_UQ_SampleDetail"
#define APIMETHOD_UQ_ProjectReportList     @"APIMETHOD_UQ_ProjectReportList"
#define APIMETHOD_UQ_SampleExec   @"APIMETHOD_UQ_SampleExec"
#define APIMETHOD_STAKE_List            @"APIMETHOD_STAKE_List"
#define APIMETHOD_STAKE_MemberList      @"APIMETHOD_STAKE_MemberList"


#define APIMETHOD_SM_ProjectList        @"APIMETHOD_SM_ProjectList"
#define APIMETHOD_SM_ConsignList        @"APIMETHOD_SM_ConsignList"
#define APIMETHOD_SM_SampleList         @"APIMETHOD_SM_SampleList"
#define APIMETHOD_SM_SampleDetail       @"APIMETHOD_SM_SampleDetail"
#define APIMETHOD_SM_SampleDetailQR   @"APIMETHOD_SM_SampleDetailQR"

#define APIMETHOD_STAKE_GetTaskList     @"APIMETHOD_STAKE_GetTaskList"
#define APIMETHOD_STAKE_UploadTaskImage     @"APIMETHOD_STAKE_UploadTaskImage"
#define APIMETHOD_STAKE_GetTaskImage     @"APIMETHOD_STAKE_GetTaskImage"
@interface CommonAPI : API
SHARED_INSTANCE_INTERFACE(CommonAPI);
@end
