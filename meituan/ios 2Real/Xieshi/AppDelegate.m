//
//  AppDelegate.m
//  LSTemplate
//
//  Created by Lessu on 13-7-15.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "AppDelegate.h"
#import "LSTabBarViewController.h"
#import "LogInViewController.h"
//#import "ZBarReaderView.h"
#import "LSUtil.h"
#import "ServerSelectViewController.h"
@implementation AppDelegate
- (NSString *) reloadDNS2 {
    //最终使用的地址
    NSString *addr = [XSShareObject DNSAnalyse:@"www.scetia.com"];
    return addr;
}
//www.schetia.com
- (NSString *) reloadDNS3 {
    //最终使用的地址
    NSString *addr = [XSShareObject DNSAnalyse:@"www.schetia.com"];
    return addr;
}
- (void) reloadDNS {
    //最终使用的地址
    NSString *addr = [XSShareObject DNSAnalyse:@"app.j1health.com"];
    if( !addr )
    {
        return;
    }
    //    g_ipAddress =  addr;
    //#ifdef DEBUG
    //    g_port = 443;
    //#else
    //    g_port = 443;
    //#endif
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    ///抽屉效果
//    self.deckController = [self generateControllerStack];
//    self.leftController = _deckController.leftController;
//    self.xsMainController = _deckController.centerController;
    
    
    

   
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    

    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isFirstLogInto"] boolValue]==1||[LoginUtil token]==nil) {
        LogInViewController *loginViewController= [[LogInViewController alloc]init];
        _rootNavigationController = [[XSNavigationViewController alloc] initWithRootViewController:loginViewController];
        self.window.rootViewController = _rootNavigationController;
    }else {
        _rootMainViewController = [[XieshiMainViewController alloc]init];
        self.window.rootViewController = self.rootMainViewController;
        self.rootMainViewController.userPowerString = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPowerStr"];
    }
    
    //    [self appearance];
//	[ZBarReaderView class];
    
    //版本更新
    NSDictionary *params = @{
                             @"PlatformType" : @"2",
                             @"SystemType"   : @"2"
                             };
    APIConnection *connection = [[USTApi sharedInstance]connectionWithApiName:APIMETHOD_UST_GetUpdateVersion params:params];
    [connection setOnSuccess:^(id result) {
        result = result[@"Data"][0];
        if (versionNameBiggerThan(result[@"Version"], [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"])){
            if ([result[@"Update_Flag"] integerValue] == 1){
                [LSDialog showDialogWithTitle:@"发现新版本" message:result[@"Description"]confirmText:@"升级" confirmCallback:^{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:result[@"Update_Url"]]];
                } cancelText:@"取消" cancelCallback:^{
                    
                }];
            }else{
                [LSDialog showAlertWithTitle:@"发现新版本" message:result[@"Description"] callBack:^{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:result[@"Update_Url"]]];
                }];
            }
        }
    }];
    [connection setOnFailed:^(NSError *error) {
        NSString *errorDescription = [error localizedDescription];
        [SVProgressHUD dismissWithError:STRING_FORMAT(@"%@",errorDescription) afterDelay:2.5f];
    }];
    [connection startAsynchronous];
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"zlUtfX8B9AhiWXuQGwlHS2ppZ52GAtIV"  generalDelegate:nil];
    if (!ret) {  
        NSLog(@"manager start failed!");  
    }  
    
    NSString *server = [LoginUtil valueForKey:@"server_select"];
    if ([server isEqualToString:@"cnnet"]||1) {
        [[USTApi sharedInstance] setServerUrl:[self reloadDNS2]];
        [[RPAPI sharedInstance] setServerUrl:[self reloadDNS2]];
        [[SMAPI sharedInstance] setServerUrl:[self reloadDNS2]];
        [[TSAPI sharedInstance] setServerUrl:[self reloadDNS2]];
        [[CommonAPI sharedInstance] setServerUrl:[self reloadDNS2]];
    }else
        if ([server isEqualToString:@"union"]) {
            [[USTApi sharedInstance] setServerUrl:[self reloadDNS3]];
            [[RPAPI sharedInstance] setServerUrl:[self reloadDNS3]];
            [[SMAPI sharedInstance] setServerUrl:[self reloadDNS3]];
            [[TSAPI sharedInstance] setServerUrl:[self reloadDNS3]];
            [[CommonAPI sharedInstance] setServerUrl:[self reloadDNS3]];
        }
    // Add the navigation controller's view to the window and display.  
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)appearance{
    //navigation
    UINavigationBar *navibarAppearance = [UINavigationBar appearance];
    if(IS_IOS7){
        
//        [navibarAppearance setBackgroundColor:[UIColor colorWithRed:41/255.0 green:124/255.0 blue:99/255.0 alpha:1.0]];
        [navibarAppearance setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor]}];
        [navibarAppearance setTintColor:[UIColor whiteColor]];
        [navibarAppearance setBarTintColor:[UIColor colorWithRed:41/255.0 green:124/255.0 blue:199/255.0 alpha:1.0]];

    }else{
        [navibarAppearance setBackgroundImage:[UIImage imageNamed:@"bg_navigation_bar"] forBarMetrics:UIBarMetricsDefault];
        [navibarAppearance setBackgroundImage:[UIImage imageNamed:@"bg_navigation_bar"] forBarMetrics:UIBarMetricsLandscapePhone];
        UIImage *barButtonNormal    = [[UIImage imageNamed:@"btn_navigation_item_n"]resizableImageWithCapInsets:UIEdgeInsetsMake(0,5,0,15)];
        UIImage *barButtonPressed   = [[UIImage imageNamed:@"btn_navigation_item_n"]resizableImageWithCapInsets:UIEdgeInsetsMake(0,5,0,15)];
        
        UIImage *backButtonNormal    = [[UIImage imageNamed:@"btn_navigation_back_n"]resizableImageWithCapInsets:UIEdgeInsetsMake(0,15,0,5)];
        UIImage *backButtonPressed   = [[UIImage imageNamed:@"btn_navigation_back_p"]resizableImageWithCapInsets:UIEdgeInsetsMake(0,15,0,5)];
        
        UIBarButtonItem *barButtonAppearance = [UIBarButtonItem appearance];
        [barButtonAppearance setBackgroundImage:barButtonNormal              forState:UIControlStateNormal          barMetrics:UIBarMetricsDefault];
        [barButtonAppearance setBackgroundImage:barButtonPressed              forState:UIControlStateHighlighted    barMetrics:UIBarMetricsDefault];
        
        [barButtonAppearance setBackgroundImage:barButtonNormal              forState:UIControlStateNormal          barMetrics:UIBarMetricsLandscapePhone];
        [barButtonAppearance setBackgroundImage:barButtonPressed              forState:UIControlStateHighlighted    barMetrics:UIBarMetricsLandscapePhone];
        
        [barButtonAppearance setBackButtonBackgroundImage:backButtonNormal   forState:UIControlStateNormal          barMetrics:UIBarMetricsDefault];
        [barButtonAppearance setBackButtonBackgroundImage:backButtonPressed   forState:UIControlStateHighlighted    barMetrics:UIBarMetricsDefault];
        
        [barButtonAppearance setBackButtonBackgroundImage:backButtonNormal   forState:UIControlStateNormal          barMetrics:UIBarMetricsLandscapePhone];
        [barButtonAppearance setBackButtonBackgroundImage:backButtonPressed   forState:UIControlStateHighlighted    barMetrics:UIBarMetricsLandscapePhone];
    }
    
    //tabbar
//    UITabBar *tabbarAppearance = [UITabBar appearance];
//    [tabbarAppearance setBackgroundImage:[UIImage imageNamed:@"bg_tabbar"]];
    
}

#pragma mark ---抽屉效果----
- (IIViewDeckController*)generateControllerStack{
    XSLeftViewController  *leftController = [[XSLeftViewController alloc] init];
    XSRightViewController *rightController = [[XSRightViewController alloc] init];
    XSMainViewController *centerController = [[XSMainViewController alloc] init];
    
    centerController = [[XSNavigationViewController alloc] initWithRootViewController:centerController];
    IIViewDeckController* deckController =  [[IIViewDeckController alloc] initWithCenterViewController:centerController
                                                                                    leftViewController:[IISideController autoConstrainedSideControllerWithViewController:leftController]
                                                                                   rightViewController:[IISideController autoConstrainedSideControllerWithViewController:rightController]];
    deckController.rightSize = DeviceWidth;
    deckController.leftSize = kscaleDeviceLength(185);
    
    deckController.centerhiddenInteractivity = IIViewDeckCenterHiddenNotUserInteractiveWithTapToClose;
    
    [deckController disablePanOverViewsOfClass:NSClassFromString(@"_UITableViewHeaderFooterContentView")];
    return deckController;
}

#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

@end
