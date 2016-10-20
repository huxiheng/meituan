//
//  LSFast.h
//  Aichi
//
//  Created by Lessu on 13-10-21.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import <Foundation/Foundation.h>

UINavigationController * wrapNavigationController(UIViewController *controller);
NSString *fullTimeStringOfTimeInterval(NSTimeInterval timeInterval);
NSString *timeStringOfTimeIntervalWithFormat(NSTimeInterval timeInterval,NSString *format);

void apiConnectionAsyncWithIndicatorAndCache(NSString *apiName,NSDictionary *params,NSString* (^onSuccess)(id result));
void apiConnectionAsyncWithIndicator(NSString *apiName,NSDictionary *params,NSString* (^onSuccess)(id result));

void apiConnectionAsyncNoIndicatorWithCache(NSString *apiName,NSDictionary *params,void (^onSuccess) (id result));
void apiConnectionAsyncNoIndicator(NSString *apiName,NSDictionary *params,void (^onSuccess) (id result));

BOOL versionNameBiggerThan(NSString *versionName1,NSString *versionName2);