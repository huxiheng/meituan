//
//  YFUtil.h
//  Yingfeng
//
//  Created by Lessu on 13-7-24.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import <Foundation/Foundation.h>


#define LSUTIL_KEY_INTERFACE(__type,__setter,__getter) \
- (void) __setter:(__type)value;\
- (__type) __getter
#define LSUTIL_KEY_IMPLEMENT(__type,_setter,__getter) \
- (void) __setter:(__type)value{\
    [self setValue:value forKey:@"key_"#__getter];\
}\
- (__type) __getter{\
    return [self valueForKey:@"key_"#__getter];\
}

#define LSUTIL_GLOBAL_KEY_INTERFACE(__type,__setter,__getter) \
+ (void) __setter:(__type)value;\
+ (__type) __getter
#define LSUTIL_GLOBAL_KEY_IMPLEMENT(__type,__setter,__getter) \
+ (void) __setter:(__type)value{\
[LSUtil setValue:value forKey:@"key_"#__getter];\
}\
+ (__type) __getter{\
    return [LSUtil valueForKey:@"key_"#__getter];\
}

@interface LSUtil : NSObject
//SHARED_INSTANCE_INTERFACE(LSUtil);

+ (void)setCurrentUserId:(NSString *)user;
+ (NSString *)currentUserId;

+ (BOOL)isLogin;
+ (void)logout;

+ (id)  valueForKey:(NSString *)key;
+ (void)setValue:(id)obj forKey:(NSString *)key;

- (id)  valueForKey:(NSString *)key;
- (void)setValue:(id) obj forKey:(NSString *)key;

@end
