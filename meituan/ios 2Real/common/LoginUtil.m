//
//  LoginUtil.m
//  Yingcheng
//
//  Created by lessu on 14-1-10.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "LoginUtil.h"

@implementation LoginUtil


LSUTIL_GLOBAL_KEY_IMPLEMENT(NSString *, setLoginUserName, loginUserName);
LSUTIL_GLOBAL_KEY_IMPLEMENT(NSString *, setLoginPassword, loginPassword);
LSUTIL_GLOBAL_KEY_IMPLEMENT(NSNumber *, setLoginType    , loginType);
LSUTIL_GLOBAL_KEY_IMPLEMENT(NSNumber *, setShouldLogin  , shouldLogin);
LSUTIL_GLOBAL_KEY_IMPLEMENT(NSString *, setToken  , token);
LSUTIL_GLOBAL_KEY_IMPLEMENT(NSString *, setnumberPhone, numberPhone);
@end
