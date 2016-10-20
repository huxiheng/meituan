//
//  HYConfig.h
//  Wireless_Business
//
//  Created by 李博 on 14-6-7.
//  Copyright (c) 2014年 j1. All rights reserved.
//

#ifndef Wireless_Business_HYConfig_h
#define Wireless_Business_HYConfig_h


#define dpEntityType id<PBMessage>

#define dpi2s(x) [NSString strintWithFormat:@"%d", x]

#define dpFormat(format, ...) [NSString stringWithFormat:format, ##__VA_ARGS__]

#define dpDeviceSystem(x) [[UIDevice currentDevice].systemVersion floatValue] >= x

#define dpBlockSelf __unsafe_unretained typeof(self) _self = self

#define dpBlockVar(var) __unsafe_unretained typeof(var) _##var = var

#define dpColor(r,g,b,a) [UIColor colorWithRed:((float)r)/255.0 green:((float)g)/255.0 blue:((float)b)/255.0 alpha:((float)a)]

#define dpThrow(aName, aReason, info) \
do \
{ \
NSString *msg = dpFormat(@"line: %d file: %s %s %@", __LINE__, __FILE__, __FUNCTION__, aReason); \
@throw [NSException exceptionWithName:aName reason:msg userInfo:info]; \
} \
while(0)

#define ctBlock(blocks) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
ct_blockWithWeakifiedSelf(self, ^id(__typeof(self) __unsafe_unretained self) { \
return (blocks);\
})\
_Pragma("clang diagnostic pop")
#define USER_FORCED_LOGOUT @"current user be forced"

#define blockself __unsafe_unretained typeof(self) _self = self

id ct_blockWithWeakifiedSelf(id self, id(^block)(id __unsafe_unretained self));

//#import "ProtocolBuffers.h"
//#import "HYRequestEntity.h"
//#import "HYResponseEntity.h"
//#import "HYBusiness.h"
//#import "System.pb.h"
//#import "HealthBook.pb.h"
//#import "Message.pb.h"
//#import "Discover.pb.h"
//#import "HealthMe.pb.h"
//#import "HealthUser.pb.h"
//#import "Baike.pb.h"
//#import "Chat.pb.h"
//#import "Doctor.pb.h"
//#import "Dossier.pb.h"
//#import "Home.pb.h"
////#import "MallCart.pb.h"
////#import "MallCategory.pb.h"
////#import "MallHome.pb.h"
////#import "MallMe.pb.h"
//#import "MallMedicine.pb.h"
//#import "Question.pb.h"
//#import "Trade.pb.h"
//#import "HealthRemind.pb.h"
////#import "MallOrder.pb.h"
////#import "MallGoods.pb.h"
////#import "MallCartNew.pb.h"
#endif
