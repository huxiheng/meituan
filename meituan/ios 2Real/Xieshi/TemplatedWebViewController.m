//
//  TemplatedWebViewController.m
//  Xieshi
//
//  Created by 明溢 李 on 14-11-18.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "TemplatedWebViewController.h"
#import "RegexKitLite.h"
@interface TemplatedWebViewController ()

@end

@implementation TemplatedWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _eventPrefix = @"app://";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setWebView:(UIWebView *)webView{
    _webView = webView;
    _webView.delegate = self;
    _webView.opaque=false;
    _webView.detectsPhoneNumbers = false;
}
- (void)loadHTMLString:(NSString *)string baseURL:(NSString *)baseURLString data:(id)data{
    VIEW_CONTROLLER_LOAD(self);
    baseURLString = [baseURLString stringByAppendingString:@"/"];
    string = [string stringByReplacingOccurrencesOfRegex:@"\\$\\{([^}]*)\\}" usingBlock:^NSString *(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        @try {
            return [self templatedWebViewController:self replaceTemplateText:capturedStrings[1] withData:data];
        }
        @catch (NSException *exception) {
            return nil;            
        }
        
    }];
    [_webView loadHTMLString:string baseURL:[NSURL URLWithString:baseURLString]];
}

- (NSString *)templatedWebViewController:(TemplatedWebViewController*) viewController replaceTemplateText:(NSString *) text withData:(id)data{
    return text;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *url = [request.URL absoluteString];

    if ([url hasPrefix:_eventPrefix]) {
        url = [url stringByReplacingOccurrencesOfString:_eventPrefix withString:@""];
        NSArray *stringComponents = [url componentsSeparatedByString:@"?"];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        if (stringComponents.count == 2) {
            NSArray *keyValues = [stringComponents[1] componentsSeparatedByString:@"&"];
            [keyValues enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger idx, BOOL *stop) {
                NSArray *item = [obj componentsSeparatedByString:@"="];
                params[item[0]]=item[1];
            }];
        }

        return [self templatedWebViewController:self sendEvent:stringComponents[0] withParams:params];
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];  
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];  
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

@interface UIWebView (JavaScriptAlert)  
-(void) webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame;  
- (BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame;  
@end  

@implementation UIWebView (JavaScriptAlert)  

- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame {  
    UIAlertView* customAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];  
    [customAlert show];  
}  
static BOOL diagStat = NO;  
static NSInteger bIdx = -1;  
- (BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame {  
    UIAlertView *confirmDiag = [[UIAlertView alloc] initWithTitle:@"提示"  
                                                          message:message  
                                                         delegate:self  
                                                cancelButtonTitle:@"取消"  
                                                otherButtonTitles:@"确定", nil];  
    
    [confirmDiag show];  
    bIdx = -1;  
    
    while (bIdx==-1) {  
        //[NSThread sleepForTimeInterval:0.2];  
        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1f]];  
    }  
    if (bIdx == 0){//取消;  
        diagStat = NO;  
    }  
    else if (bIdx == 1) {//确定;  
        diagStat = YES;  
    }  
    return diagStat;  
}  

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{  
    bIdx = buttonIndex;  
}  

@end  
