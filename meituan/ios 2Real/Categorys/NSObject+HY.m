//
//  NSObject+HY.m
//  Wireless
//
//  Created by 李博 on 14-7-5.
//  Copyright (c) 2014年 j1. All rights reserved.
//

#import "NSObject+HY.h"

#import <objc/runtime.h>

@implementation NSObject (HY)

+ (NSString *) HYClassName {
    const char* className = class_getName(self);
    return [NSString stringWithUTF8String:className];
}

- (NSString *) HYClassName {
    const char* className = class_getName(self.class);
    return [NSString stringWithUTF8String:className];
}

@end
