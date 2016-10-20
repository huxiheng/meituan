//
//  DeviceAuthorizationManager.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/20.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceAuthorizationManager : NSObject
///是否有访问🎤的权限
+(BOOL)DeviceMicroPhone;
///是否有访问📷的权限
+(BOOL)DevicePhoto;
///是否有访问相册的权限
+(BOOL)DeviceAlbum;
///是否打开通知功能
+(BOOL)DeviceNotiRemote;
@end
