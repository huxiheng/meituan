//
//  CllocationUser.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/10/13.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "CllocationUserVC.h"

@implementation CllocationUserVC
-(instancetype)init{
    if (self==[super init]) {
        [self setSubViews];
    }
    return self;
}

-(void)setSubViews{
//    locationM = [[CLLocationManager alloc] init];
//    locationM.delegate = self;
//    
//    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
//        //        [locationM requestAlwaysAuthorization];
//        [locationM requestWhenInUseAuthorization];
//        if ([[UIDevice currentDevice].systemVersion floatValue]>=9.0) {
//            locationM.allowsBackgroundLocationUpdates = YES;
//            
//        }
//    }
//    
//    locationM.distanceFilter = 100;
//    locationM.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
//    
//    
//    if ([[UIDevice currentDevice].systemVersion floatValue]>=9.0) {
//        [locationM requestLocation];
//    }else{
//        [locationM startUpdatingLocation];
//            [locationM startMonitoringSignificantLocationChanges];
//    }
}
#pragma cllocationManagerdelegate ---
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *newLocation = [locations lastObject];
    self.locationUser = newLocation;
}

//-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
//    
//}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"用户没有决定");
            
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"受限制");
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"前台授权");
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"前后台授权");
            break;
        case kCLAuthorizationStatusDenied:
            if ([CLLocationManager locationServicesEnabled]) {
                [LSDialog showAlertWithTitle:@"提示" message:@"请打开在‘设置>隐私>检测管理的定位服务’" callBack:nil];
                
            }else{
                [LSDialog showAlertWithTitle:@"提示" message:@"请打开在‘设置>隐私>定位服务’" callBack:nil];
            }
            break;
            
        default:
            NSLog(@"none");
            break;
    }
}
@end
