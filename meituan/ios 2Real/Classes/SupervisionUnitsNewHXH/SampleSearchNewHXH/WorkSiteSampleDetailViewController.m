//
//  WorkSiteSampleDetailViewController.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-1-14.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import "WorkSiteSampleDetailViewController.h"

@interface WorkSiteSampleDetailViewController ()

@end

@implementation WorkSiteSampleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *htmlName;
    if (_isQRDetail) {
        htmlName  = @"ws_sample_detail_qr";
    }else{
        htmlName  = @"ws_sample_detail";
    }
    NSString *bundlePath = [[NSBundle mainBundle]pathForResource:@"html" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *html = [NSString stringWithContentsOfURL:[bundle URLForResource:htmlName withExtension:@"html"] encoding:NSUTF8StringEncoding error:nil];
    [self loadHTMLString:html baseURL:bundlePath data:_data];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (NSString *)templatedWebViewController:(TemplatedWebViewController *)viewController replaceTemplateText:(NSString *)text withData:(id)data{
    id ret= data[text];
    if(ret == NULL){
        if ([text isEqualToString: @"QR_Code"]) {
            return _qrcode;
        }
        return @"无字段";
    }
    if (IS_STRING(ret)) {
        return  ret;
    }else{
        return @"类型不匹配";
    }
}
- (BOOL)templatedWebViewController:(TemplatedWebViewController *)viewController sendEvent:(NSString *)event withParams:(NSDictionary *)params{
    return false;
}
@end
