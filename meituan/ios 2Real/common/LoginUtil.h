//
//  LoginUtil.h
//  Yingcheng
//
//  Created by lessu on 14-1-10.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "LSUtil.h"
@interface LoginUtil : LSUtil


LSUTIL_GLOBAL_KEY_INTERFACE(NSString *, setLoginUserName, loginUserName);
LSUTIL_GLOBAL_KEY_INTERFACE(NSString *, setLoginPassword, loginPassword);
LSUTIL_GLOBAL_KEY_INTERFACE(NSNumber *, setLoginType    , loginType);
LSUTIL_GLOBAL_KEY_INTERFACE(NSNumber *, setShouldLogin  , shouldLogin);

LSUTIL_GLOBAL_KEY_INTERFACE(NSString *, setToken  , token);
LSUTIL_GLOBAL_KEY_INTERFACE(NSString *, setnumberPhone, numberPhone);
@end
