//
//  DeviceAuthorizationManager.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/20.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "DeviceAuthorizationManager.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@implementation DeviceAuthorizationManager
///是否有使用麦克风的权限
+(BOOL)DeviceMicroPhone {
    if ([[AVAudioSession sharedInstance] respondsToSelector:@selector(requestRecordPermission:)]) {
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
            if (granted) {
                NSLog(@"允许使用麦克风！");
                
            }
            else {
                NSLog(@"不允许使用麦克风！");
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"麦克风被禁用" message:[NSString stringWithFormat:@"请在iPhone的\"设置－隐私－麦克风\"中允许%@访问你的麦克风。",kAPPDisplayName] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
    }
    return NO;
}
///是否有访问📷的权限
+(BOOL)DevicePhoto {
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"无法使用相机" message:[NSString stringWithFormat:@"请在iPhone的\"设置－隐私－相机\"中允许%@访问您的相机。",kAPPDisplayName] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    else {
        return YES;
    }
}
///是否有访问相册的权限
+(BOOL)DeviceAlbum {
    return YES;
}
///是否打开通知功能
+(BOOL)DeviceNotiRemote{
    BOOL isNotifyAlert = NO, isNotifySound = NO;
    if (IOS8)
    {
        UIUserNotificationType types = [[UIApplication sharedApplication] currentUserNotificationSettings].types;
        isNotifyAlert = (types & UIUserNotificationTypeAlert) == UIUserNotificationTypeAlert;
        isNotifySound = (types & UIUserNotificationTypeSound) == UIUserNotificationTypeSound;
    }
    else
    {
        UIRemoteNotificationType types = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        isNotifyAlert = (types & UIRemoteNotificationTypeAlert) == UIRemoteNotificationTypeAlert;
        isNotifySound = (types & UIRemoteNotificationTypeSound) == UIRemoteNotificationTypeSound;
    }
    //    debugLog(@"-------------推送开关, 接收：%@, 声音：%@", [NSString fromBOOL:isNotifyAlert],[NSString fromBOOL:isNotifySound] );
    return isNotifyAlert;
}
@end
