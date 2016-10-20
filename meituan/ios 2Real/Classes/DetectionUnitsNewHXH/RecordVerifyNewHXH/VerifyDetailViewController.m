//
//  ApplyDetailViewController.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-1-8.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "VerifyDetailViewController.h"

@interface VerifyDetailViewController ()

@end

@implementation VerifyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title=@"记录详情";
    [self dataRequest];

}
- (void)dataRequest{
    NSDictionary *params = @{
                             @"ConsignId":_consignId,
                             @"Token":[LoginUtil token]
                             };
    APIConnection *connection = [[RPAPI sharedInstance]connectionWithApiName:APIMETHOD_RP_VERIFY_DETAIL_SAMPLE params:params];
    [connection setOnSuccess:^(id result) {
        NSString *bundlePath = [[NSBundle mainBundle]pathForResource:@"html" ofType:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        NSString *html = [NSString stringWithContentsOfURL:[bundle URLForResource:@"verify_detail" withExtension:@"html"] encoding:NSUTF8StringEncoding error:nil];
        @try {
            [self loadHTMLString:html baseURL:bundlePath data:result[kAPIConnectionStandartDataKey][0]];
            [SVProgressHUD dismiss];
        }
        @catch (NSException *exception) {
            [SVProgressHUD dismissWithError:@"数据错误！"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [connection setOnFailed:^(NSError *error) {
        NSString *errorDescription = [error localizedDescription];
        [SVProgressHUD dismissWithError:STRING_FORMAT(@"%@",errorDescription) afterDelay:2.5f];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [SVProgressHUD show];
    [connection startAsynchronous];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (NSString *)templatedWebViewController:(TemplatedWebViewController*) viewController replaceTemplateText:(NSString *)text withData:(id)data{
    
    if ([text isEqualToString:@"ParamInfo"]) {
        if (IS_ARRAY( data[text] )) {
            NSArray *paramInfo = data[text];
            NSMutableString* ret = [NSMutableString string];
            
            [paramInfo enumerateObjectsUsingBlock:^(NSDictionary* params, NSUInteger idx, BOOL *stop) {
                [ret appendFormat:@"<li class=\"detail-switch-li\"><p class=\"detail-switch-title\">%@</p><p class=\"detail-switch-content\">%@(检测：%@，标准:%@)</p></li>",
                    params[@"ParameterName"] ,
                    params[@"UCResultValue"],
                    params[@"UCTestValue"],
                    params[@"UCStandardValue"]
                 ];
            }];
        }else{
            return @"";
        }
    }
    return data[text]==nil ? @"字段不存在" : data[text];
}
- (BOOL)templatedWebViewController:(TemplatedWebViewController*) viewController sendEvent:(NSString *)event withParams:(NSDictionary *)params{
    return false;
}
@end
