//
//  CommonAPI.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-1-8.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "CommonAPI.h"
#import "RegexKitLite.h"
@implementation CommonAPI
SHARED_INSTANCE_IMPLEMENT(CommonAPI, _commonApi, );

- (instancetype)init
{
    self = [super init];
    if (self) {
        _apiConfig = @{
                       APISiteUrlKey           : @"www.scetia.com/scetia.app.ws",
                       APIHTTPMethodKey        : @"http",
                       APIResultFormatKey      : ^(NSString *input,NSString **output){
                           NSString *responseString = input;
                           responseString = [responseString stringByMatching:@">\\{.+\\}</"];
                           responseString = [responseString stringByReplacingOccurrencesOfString:@">{" withString:@"{" ];
                           responseString = [responseString stringByReplacingOccurrencesOfString:@"}</" withString:@"}" ];
                           *output = responseString;
                       }
                       };
        
        _apiMethod = @{
                       
                       APIMETHOD_ItemItemSource       :API_DEF_GET(@"/ServiceSource.asmx/ItemItemSource"),
                       APIMETHOD_ItemKindSource   :API_DEF_GET(@"/ServiceSource.asmx/ItemKindSource"),
                       APIMETHOD_BHGItemSource    : API_DEF_GET(@"/ServiceSource.asmx/BHGItemSource"),                 
                       APIMETHOD_UQ_ReportList    : API_DEF_GET(@"/ServiceUQ.asmx/ReportList"),
                       APIMETHOD_UQ_ReportDetail  : API_DEF_GET(@"/ServiceUQ.asmx/ProjectConsign"),
                       APIMETHOD_UQ_SampleList    : API_DEF_GET(@"/ServiceUQ.asmx/SampleList"),
                       APIMETHOD_UQ_SampleDetail  : API_DEF_GET(@"/ServiceUQ.asmx/SampleDetail"),
                       APIMETHOD_UQ_SampleExec    : API_DEF_GET(@"/ServiceUQ.asmx/ExecUqSamle"),
                       APIMETHOD_SM_ProjectList   : API_DEF_GET(@"/ServiceSM.asmx/ProjectList"),
                       APIMETHOD_SM_ConsignList   : API_DEF_GET(@"/ServiceSM.asmx/ConsignList"),
                       APIMETHOD_SM_SampleList    : API_DEF_GET(@"/ServiceSM.asmx/SampleList"),
                       APIMETHOD_SM_SampleDetail  : API_DEF_GET(@"/ServiceSM.asmx/SampleDetail"),
                       APIMETHOD_SM_SampleDetailQR: API_DEF_GET(@"/ServiceSM.asmx//SampleInfoByCode"),
                       
                       APIMETHOD_STAKE_List       : API_DEF_GET(@"/ServiceStake.asmx/GetMapList"),
                       APIMETHOD_STAKE_MemberList : API_DEF_GET(@"/ServiceStake.asmx/GetMemberList"),
                       
                       
                       APIMETHOD_STAKE_GetTaskList     : API_DEF_GET(@"/ServiceStake.asmx/GetTaskList"),     
                       APIMETHOD_STAKE_UploadTaskImage : API_DEF_POST(@"/ServiceStake.asmx/UploadTaskImage"),
                       APIMETHOD_STAKE_GetTaskImage    : API_DEF_GET(@"/ServiceStake.asmx/GetTaskImage")
                       };
    }
    return self;
}
- (void)setServerUrl:(NSString *)serverUrl{
    _apiConfig = [_apiConfig mutableCopy];
    ((NSMutableDictionary *)_apiConfig)[APISiteUrlKey] = [NSString stringWithFormat:@"%@/scetia.app.ws",serverUrl];
}
- (APIConnection *)connectionWithApiName:(NSString *) apiName params:(NSDictionary *)params{
    return [super connectionWithApiName:apiName params:XIESHI_PARAMS(params)];
}
@end
