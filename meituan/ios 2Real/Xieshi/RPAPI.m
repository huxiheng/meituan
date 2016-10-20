//
//  RPAPI.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-1-8.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "RPAPI.h"
#import "RegexKitLite.h"
@implementation RPAPI
SHARED_INSTANCE_IMPLEMENT(RPAPI,_rpapi,);

- (instancetype)init
{
    self = [super init];
    if (self) {
        _apiConfig = @{
                       APISiteUrlKey           : @"www.scetia.com/scetia.app.ws/ServiceRP.asmx",
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
                       APIMETHOD_RP_VERIFY_DETAIL_SAMPLE      : API_DEF_GET(@"/RecordPreviewList"),
                       APIMETHOD_RP_APPLY_DETAIL_REPORT       : API_DEF_GET(@"/ReportPreviewList"),
                       };
    }
    return self;
}
- (void)setServerUrl:(NSString *)serverUrl{
    _apiConfig = [_apiConfig mutableCopy];
    ((NSMutableDictionary *)_apiConfig)[APISiteUrlKey] = [NSString stringWithFormat:@"%@/scetia.app.ws/ServiceRP.asmx",serverUrl];
}
- (APIConnection *)connectionWithApiName:(NSString *) apiName params:(NSDictionary *)params{
    return [super connectionWithApiName:apiName params:XIESHI_PARAMS(params)];
}
@end
