//
//  USTApi.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-28.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "USTApi.h"
#import "RegexKitLite.h"
#undef API_DEF_GET
#define API_DEF_GET(url)  @{API_URL: url}
@implementation USTApi
SHARED_INSTANCE_IMPLEMENT(USTApi, _ustApi, );


- (instancetype)init
{
    self = [super init];
    if (self) {
        _apiConfig = @{
                      APISiteUrlKey           : @"www.scetia.com/scetia.app.ws/ServiceUST.asmx",
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
                       APIMETHOD_UST_AuditedExamedItem    : API_DEF_GET(@"/Get_ItemItem"),
                       APIMETHOD_UST_AuditedExamedKind      : API_DEF_GET(@"/Get_ItemKind"),
                       
                       APIMETHOD_UST_AuditedList            : API_DEF_GET(@"/Get_AppAuditedList"),
                      APIMETHOD_UST_AuditList               : API_DEF_GET(@"/Get_AuditList"),
                        APIMETHOD_UST_Audit                  : API_DEF_GET(@"/Set_AuditList"),
                       
                       APIMETHOD_UST_ExamedList             : API_DEF_GET(@"/Get_AppExamedList"),
                      APIMETHOD_UST_ExamList               : API_DEF_GET(@"/Get_ExamRecordList"),
                      APIMETHOD_UST_Exam                   : API_DEF_GET(@"/Set_ExamList"),
                      
                      APIMETHOD_UST_UserLogin              : API_DEF_GET(@"/UserLogin"),
                      APIMETHOD_UST_BindStart              : API_DEF_GET(@"/User_BindStart"),
                       APIMETHOD_UST_UnBind                :API_DEF_GET(@"/User_UnBind"),
                       APIMETHOD_UST_SearchYanZhengMa                :API_DEF_GET(@"/SearchYanZhengMa"),
                      APIMETHOD_UST_BindEnd                : API_DEF_GET(@"/User_BindEnd"),
                      APIMETHOD_UST_ChangePassWord         : API_DEF_GET(@"/User_ChangePassWord"),
                       APIMETHOD_UST_GetUpdateVersion      : API_DEF_GET(@"/GetAppVersion")
                      };
    }
    return self;
}
- (void)setServerUrl:(NSString *)serverUrl{
    _apiConfig = [_apiConfig mutableCopy];
    ((NSMutableDictionary *)_apiConfig)[APISiteUrlKey] = [NSString stringWithFormat:@"%@/scetia.app.ws/ServiceUST.asmx",serverUrl];
}
- (APIConnection *)connectionWithApiName:(NSString *) apiName params:(NSDictionary *)params{
    return [super connectionWithApiName:apiName params:XIESHI_PARAMS(params)];
}
@end
