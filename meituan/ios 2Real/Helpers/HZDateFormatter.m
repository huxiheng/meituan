//
//  HZDateFormatter.m
//  testheaderAndfooter
//
//  Created by huazi on 14-3-21.
//  Copyright (c) 2014年 huifu. All rights reserved.
//

#import "HZDateFormatter.h"

@implementation HZDateFormatter
+(NSString *)returnNowDate
{
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmm"];
    NSString *returnStr =[dateFormatter stringFromDate:[NSDate date]];
    return returnStr;
}
+(NSString *)returnNowDateType:(NSString *)strType
{
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:strType];
    NSString *returnStr =[dateFormatter stringFromDate:[NSDate date]];
    return returnStr;
}
+(NSString *)returnStrFromDate:(NSDate *)date andStr:(NSString *)strType
{
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:strType];
    NSString *returnStr =[dateFormatter stringFromDate:date];
    return returnStr;

}
+(NSString *)returnStrFromSecond:(NSString *)sendTime
{
    
    NSDate *dateSend =[NSDate dateWithTimeIntervalSince1970:[sendTime doubleValue]/1000];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit;
    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:dateSend];
    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    
    // 2.格式化日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if ([cmp1 day] == [cmp2 day]) { // 今天
        formatter.dateFormat = @"今天 HH:mm";
    } else if ([cmp1 year] == [cmp2 year]) { // 今年
        formatter.dateFormat = @"MM-dd HH:mm";
    } else {
        formatter.dateFormat = @"yyyy-MM-dd";
    }
    NSString *time = [formatter stringFromDate:dateSend];
    
 return time;
    
   
    
    
}
+(NSString *)returnStrFromTimeStr:(NSString *)sendTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =@"yyyyMMddHHmm";
    NSDate *dateSend =[formatter dateFromString:sendTime];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit;
    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:dateSend];
    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    
    // 2.格式化日期
   
    if ([cmp1 day] == [cmp2 day]) { // 今天
        formatter.dateFormat = @"今天";
    } else if ([cmp1 year] == [cmp2 year]) { // 今年
        formatter.dateFormat = @"MM-dd";
    } else {
        formatter.dateFormat = @"yyyy-MM-dd";
    }
    NSString *time = [formatter stringFromDate:dateSend];
    
    return time;

}

+(NSString *)returnSecondNowDateSince1970
{
    NSTimeInterval second =[[NSDate date] timeIntervalSince1970]*1000;
    return [NSString stringWithFormat:@"%.0f",second];
}
+(NSString *)returnSecondNowDateToLaterDate:(NSString *)laterDate
{
    
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSTimeInterval second =[[NSDate date] timeIntervalSinceDate:[dateFormatter dateFromString:laterDate]];
    return [NSString stringWithFormat:@"%.0f",second];
    
}
+(NSDate *)returnDateWithTimeStr:(NSString *)strTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =@"yyyy.MM.dd HH:mm";
    NSDate *date =[formatter dateFromString:strTime];
    return date;
}
+(NSString *)returnDateWithTimeInterval:(NSTimeInterval)timeInterval{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDate *dateSend =[NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:dateSend];
    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    if ([cmp1 year] == [cmp2 year]) { // 今年
        formatter.dateFormat = @"MM月dd日";
    } else {
        formatter.dateFormat = @"yyyy年MM月dd日";
    }
    NSString *string = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
    return string;
}
+(NSString *)returnDateWithTimeIntervalToServer:(NSTimeInterval)timeInterval{
   
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMdd";
    NSString *string = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
    return string;
}
+(NSString *)returnDateStrFromTimeStr:(NSString *)sendTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =@"yyyyMMddHHmmss";
    NSDate *dateSend =[formatter dateFromString:sendTime];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit;
    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:dateSend];
    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    if ([cmp1 year] == [cmp2 year]) { // 今年
        formatter1.dateFormat = @"MM月dd日";
    } else {
        formatter1.dateFormat = @"yyyy年MM月dd日";
    }
    NSString *time = [formatter1 stringFromDate:dateSend];
    return time;
}

+(NSString *)returnDateStrDateFromTimeStr:(NSString *)sendTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =@"yyyyMMddHHmm";
    NSDate *dateSend =[formatter dateFromString:sendTime];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    formatter1.dateFormat = @"yyyy/MM/dd";
    NSString *time = [formatter1 stringFromDate:dateSend];
    return time;

}
+(NSString *)returnDateStrTimeFromTimeStr:(NSString *)sendTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =@"yyyyMMddHHmm";
    NSDate *dateSend =[formatter dateFromString:sendTime];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    formatter1.dateFormat = @"HH:mm";
    NSString *time = [formatter1 stringFromDate:dateSend];
    return time;
}
+(NSString *)returnDateStrWithType:(NSString *)sendTime AndType:(NSString *)type
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =@"yyyyMMddHHmm";
    NSDate *dateSend =[formatter dateFromString:sendTime];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    formatter1.dateFormat = type;
    NSString *time = [formatter1 stringFromDate:dateSend];
    return time;
}
+(NSString *)returnDateStrWithType2:(NSString *)sendTime AndType:(NSString *)type
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =@"yyyyMMddHHmmss";
    NSDate *dateSend =[formatter dateFromString:sendTime];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    formatter1.dateFormat = type;
    NSString *time = [formatter1 stringFromDate:dateSend];
    return time;
}
+(NSString *)returnDateStrDateFromTimeStr2:(NSString *)sendTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =@"yyyyMMddHHmmss";
    NSDate *dateSend =[formatter dateFromString:sendTime];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    formatter1.dateFormat = @"yyyy/MM/dd";
    NSString *time = [formatter1 stringFromDate:dateSend];
    return time;
    
}
+(NSString *)returnDateStrTimeFromTimeStr2:(NSString *)sendTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =@"yyyyMMddHHmmss";
    NSDate *dateSend =[formatter dateFromString:sendTime];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    formatter1.dateFormat = @"HH:mm";
    NSString *time = [formatter1 stringFromDate:dateSend];
    return time;
}
+(NSString *)returnNowTimestamp
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}
+(NSString *)returnNowDay {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =@"dd";
    NSString *strDay =[formatter stringFromDate:[NSDate date]];
    return strDay;
}
+(NSString *)returnNowMonth {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =@"MM";
    NSString *strMonth =[formatter stringFromDate:[NSDate date]];
    NSDictionary *dicMapMonth =[NSDictionary dictionaryWithObjectsAndKeys:@"一月",@"01",@"二月",@"02",@"三月",@"03",@"四月",@"04",@"五月",@"05",@"六月",@"06",@"七月",@"07",@"八月",@"08",@"九月",@"09",@"十月",@"10",@"十一月",@"11",@"十二月",@"12", nil];
    return [dicMapMonth objectForKey:strMonth];
}

+(NSInteger)returnNowMonthHaveDays {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =@"yyyy";
    NSString *strYear =[formatter stringFromDate:[NSDate date]];
    formatter.dateFormat =@"MM";
    NSString *strMonth =[formatter stringFromDate:[NSDate date]];
    NSDictionary *dicMapDays =[NSDictionary dictionaryWithObjectsAndKeys:@"31",@"01",@"28",@"02",@"31",@"03",@"30",@"04",@"31",@"05",@"30",@"06",@"31",@"07",@"31",@"08",@"30",@"09",@"31",@"10",@"30",@"11",@"31",@"12", nil];
    if ([strYear integerValue]%4==0&&[strMonth isEqualToString:@"02"]) {
        return [[dicMapDays objectForKey:strMonth] integerValue]+1;
    }
    return [[dicMapDays objectForKey:strMonth] integerValue];
}
+(NSInteger)returnMonthStartDate {
//    NSArray * arrWeek=[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6", nil];
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    formatter.dateFormat =@"yyyyMMdd";
    NSDate *dateNow = [NSDate date];
    NSString *strDate =[formatter stringFromDate:dateNow];
    NSDate *monthFirst =[formatter dateFromString:[NSString stringWithFormat:@"%@%@",[strDate substringToIndex:6],@"01"]];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:monthFirst];
    NSInteger week = [comps weekday];
    NSInteger year=[comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSLog(@"%li%li%li%li",year,month,day,week);
    return week-1;
//    m_labDate.text=[NSString stringWithFormat:@"%d年%d月",year,month];
//    m_labToday.text=[NSString stringWithFormat:@"%d",day];
//    m_labWeek.text=[NSString stringWithFormat:@"%@",[arrWeek objectAtIndex:week]];
}
+(NSString *)returnDateStringWithTimestamp:(NSString *)Timestamp{
    NSDate *confromTimeSp =[NSDate dateWithTimeIntervalSince1970:[Timestamp doubleValue]];
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSTimeZone *timeZone =[NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    NSString *confromTimespStr =[formatter stringFromDate:confromTimeSp];
    
    NSDate *dateSend =[formatter dateFromString:confromTimespStr];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:dateSend];
    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    
    // 2.格式化日期
    
    if ([cmp1 day] == [cmp2 day]&&[cmp1 month]==[cmp2 month]&&[cmp1 year] == [cmp2 year]) { // 今天
        formatter.dateFormat = @"HH:mm";
    } else if ([cmp1 year] == [cmp2 year]) { // 今年
        formatter.dateFormat = @"MM-dd";
    } else {
        formatter.dateFormat = @"yyyy-MM-dd";
    }
    NSString *time = [formatter stringFromDate:dateSend];
    return time;
}
+(NSString *)returnDateStringWithDateString:(NSString *)dateString {
//    NSDate *confromTimeSp =[NSDate dateWithTimeIntervalSince1970:[Timestamp doubleValue]];
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSTimeZone *timeZone =[NSTimeZone systemTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *confromTimespStr =dateString;
    
    NSDate *dateSend =[formatter dateFromString:confromTimespStr];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:dateSend];
    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    
    // 2.格式化日期
    
    if ([cmp1 day] == [cmp2 day]&&[cmp1 month]==[cmp2 month]&&[cmp1 year] == [cmp2 year]) { // 今天
        formatter.dateFormat = @"HH:mm";
    } else if ([cmp1 year] == [cmp2 year]) { // 今年
        formatter.dateFormat = @"MM-dd";
    } else {
        formatter.dateFormat = @"yyyy-MM-dd";
    }
    NSString *time = [formatter stringFromDate:dateSend];
    return time;
}

+(NSString *)returnDateStringWithTimestamp:(NSString *)Timestamp dateFormat:(NSString *)dateFormat
{
    NSDate *confromTimeSp =[NSDate dateWithTimeIntervalSince1970:[Timestamp doubleValue]];
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSTimeZone *timeZone =[NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:dateFormat];
    
    NSString *confromTimespStr =[formatter stringFromDate:confromTimeSp];
    NSDate *dateSend =[formatter dateFromString:confromTimespStr];
    
    NSString *time = [formatter stringFromDate:dateSend];
    return time;
}
@end
