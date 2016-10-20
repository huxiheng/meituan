//
//  SMAPI.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-1-7.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "SMAPI.h"
#import "RegexKitLite.h"
@implementation SMAPI
SHARED_INSTANCE_IMPLEMENT(USTApi, _smApi, );

- (instancetype)init
{
    self = [super init];
    if (self) {
        _apiConfig = @{
                       APISiteUrlKey           : @"www.scetia.com/scetia.app.ws/ServiceSM.asmx",
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
                       APIMETHOD_SM_ConsignList                 : API_DEF_GET(@"/ConsignList"),
                       APIMETHOD_SM_ProjectList                 : API_DEF_GET(@"/ProjectList"),
                       APIMETHOD_SM_SampleDetail                : API_DEF_GET(@"/SampleDetail"),
                       APIMETHOD_SM_SampleInfoByCode            : API_DEF_GET(@"/SampleInfoByCode"),
                       APIMETHOD_SM_SampleList                  : API_DEF_GET(@"/SampleList")
                       };
    }
    return self;
}
- (void)setServerUrl:(NSString *)serverUrl{
    _apiConfig = [_apiConfig mutableCopy];
    ((NSMutableDictionary *)_apiConfig)[APISiteUrlKey] = [NSString stringWithFormat:@"%@/scetia.app.ws/ServiceSM.asmx",serverUrl];
}
- (APIConnection *)connectionWithApiName:(NSString *) apiName params:(NSDictionary *)params{
    return [super connectionWithApiName:apiName params:XIESHI_PARAMS(params)];
}
@end
