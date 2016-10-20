//
//  HZDateFormatter.h
//  testheaderAndfooter
//
//  Created by huazi on 14-3-21.
//  Copyright (c) 2014年 huifu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZDateFormatter : NSObject

+(NSString *)returnNowDate;
+(NSDate *)returnDateWithTimeStr:(NSString *)strTime;
+(NSString *)returnNowDateType:(NSString *)strType;
+(NSString *)returnStrFromDate:(NSDate *)date andStr:(NSString *)strType;
+(NSString *)returnStrFromSecond:(NSString *)sendTime;
+(NSString *)returnSecondNowDateSince1970;
+(NSString *)returnSecondNowDateToLaterDate:(NSString *)laterDate;
+(NSString *)returnStrFromTimeStr:(NSString *)sendTime;
+(NSString *)returnDateStrFromTimeStr:(NSString *)sendTime;
+(NSString *)returnDateStrDateFromTimeStr:(NSString *)sendTime;
+(NSString *)returnDateStrTimeFromTimeStr:(NSString *)sendTime;
+(NSString *)returnDateStrWithType:(NSString *)sendTime AndType:(NSString *)type;
+(NSString *)returnDateStrWithType2:(NSString *)sendTime AndType:(NSString *)type;
+(NSString *)returnDateStrDateFromTimeStr2:(NSString *)sendTime;
+(NSString *)returnDateStrTimeFromTimeStr2:(NSString *)sendTime;
+(NSString *)returnNowTimestamp;
/**
 *  当前日期的日
 *
 *  @return 1、2...31
 */
+(NSString *)returnNowDay;
/**
 *  当前月份
 *
 *  @return 十月
 */
+(NSString *)returnNowMonth;
/**
 *  当月的天数
 *
 *  @return 28、29、30、31
 */
+(NSInteger)returnNowMonthHaveDays;
/**
 *  返回当前月的1号是周几
 *
 *  @return 1、2...7
 */
+(NSInteger)returnMonthStartDate;
+(NSString *)returnDateStringWithTimestamp:(NSString *)Timestamp;
+(NSString *)returnDateStringWithDateString:(NSString *)dateString;
+(NSString *)returnDateStringWithTimestamp:(NSString *)Timestamp dateFormat:(NSString *)dateFormat;
+(NSString *)returnDateWithTimeInterval:(NSTimeInterval)timeInterval;
+(NSString *)returnDateWithTimeIntervalToServer:(NSTimeInterval)timeInterval;
@end
