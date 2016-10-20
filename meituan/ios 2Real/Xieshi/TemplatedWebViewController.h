//
//  TemplatedWebViewController.h
//  Xieshi
//
//  Created by 明溢 李 on 14-11-18.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TemplatedWebViewController;
@protocol TemplatedWebViewControllerDelegate <NSObject>
@required

- (NSString *)templatedWebViewController:(TemplatedWebViewController*) viewController replaceTemplateText:(NSString *)text withData:(id)data;
- (BOOL)templatedWebViewController:(TemplatedWebViewController*) viewController sendEvent:(NSString *)event withParams:(NSDictionary *)params;

@end


@interface TemplatedWebViewController : UIViewController<UIWebViewDelegate,TemplatedWebViewControllerDelegate>
{
__unsafe_unretained UIWebView *_webView;
}


@property(nonatomic,assign) IBOutlet UIWebView *webView;

@property(nonatomic,retain) NSString *eventPrefix;

- (void)loadHTMLString:(NSString *)string baseURL:(NSString *)baseURLString data:(id)data;

@end

