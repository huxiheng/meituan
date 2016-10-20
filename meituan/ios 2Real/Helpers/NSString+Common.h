//
//  NSString+Common.h
//  car4S
//
//  Created by huazi on 14-2-20.
//  Copyright (c) 2014年 huifu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)

///MD5加密
+(NSString *)MD5:(NSString *)str;
///Base64加密
+(NSString *)Base64encode:(NSString *)encodeStr;
///Base64解密
+(NSString *)Base64decode:(NSString *)decodeStr;
///是否为空，包含 也为空
+(BOOL) isEmpty:(NSString *) str;
///是否为邮箱
+(BOOL)isValidateEmail:(NSString *)msg;
///是否为电话号码
+(BOOL)isMobileNumber:(NSString *)mobileNum;

/// 根据string返回view需要的相应高度
+(CGFloat)calculateTextHeight:(CGFloat)widthInput Content:(NSString *)strContent  font:(UIFont *)font;
/// 根据string返回view需要的相应宽度
+(CGFloat)calculateTextWidth:(CGFloat)widthInput Content:(NSString *)strContent  font:(UIFont *)font;
/// 根据
+(CGSize)calculateTextSize:(CGSize)size Content:(NSString *)strContent  font:(UIFont *)font;
+(BOOL)isStandardPassword:(NSString *)str andView:(UIView *)view;
+(BOOL)isStandardFargatherName:(NSString *)str andView:(UIView *)view;
+(NSString *)stringRemoveEmoji:(NSString *)stringRemoveEmoji;
+(NSString *)strarrNamesToStr:(NSArray *)arrayNames;
+(CGFloat)calculateTextHeight:(NSArray *)arrIems;
+(NSMutableAttributedString *)calculateUpdateStringColor:(NSString *)willUpdateStr  allTextString:(NSString *)allTextStr willUpdateStringColor:(UIColor *)WillUpdateColor;
/**
 *  返回会话列表的ids
 */
+(NSString *)returnSessionsIds;

/*
 获取用户头像路径
 */
+(NSString*)returnImagesUser;
@end
