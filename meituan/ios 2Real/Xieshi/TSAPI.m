//
//  TSAPI.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-1-7.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "TSAPI.h"
#import "RegexKitLite.h"
@implementation TSAPI
SHARED_INSTANCE_IMPLEMENT(TSAPI, _ustApi, );

- (instancetype)init
{
    self = [super init];
    if (self) {
        _apiConfig = @{
                       APISiteUrlKey           : @"www.scetia.com/scetia.app.ws/ServiceTS.asmx",
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
                       APIMETHOD_TS_TODAY_MANAGE_UNIT       : API_DEF_GET(@"/ManageUnitTodayStatisProjectList"),
                       APIMETHOD_TS_TODAY                   : API_DEF_GET(@"/DetectionTodayStatis"),
                       APIMETHOD_TS_TODAY_MANAGE_UNIT_DETAIL:API_DEF_GET(@"/ManageUnitTodayStatisInfoList")
                                                                        
                       };
    }
    return self;
}
- (void)setServerUrl:(NSString *)serverUrl{
    _apiConfig = [_apiConfig mutableCopy];
    ((NSMutableDictionary *)_apiConfig)[APISiteUrlKey] = [NSString stringWithFormat:@"%@/scetia.app.ws/ServiceTS.asmx",serverUrl];
}
- (APIConnection *)connectionWithApiName:(NSString *) apiName params:(NSDictionary *)params{
    return [super connectionWithApiName:apiName params:XIESHI_PARAMS(params)];
}
@end
