//
//  TodaySearchDayView.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/21.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "TodaySearchDayView.h"
#import "LSDateNewActionSheet.h"

@implementation TodaySearchDayView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initWithSubviews];
    }
    return self;
}

- (void)initWithSubviews{
    UIView *viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, kscaleDeviceHeight(40))];
    viewBG.backgroundColor = [UIColor colorWithRed:41/255.0 green:124/255.0 blue:199/255.0 alpha:1.0];
    [self addSubview:viewBG];
    
    
    self.btnBeforeDay = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnBeforeDay.frame = CGRectMake(kscaleDeviceWidth(7), kscaleDeviceHeight(12), kscaleDeviceWidth(55), kscaleDeviceHeight(15));
    [self.btnBeforeDay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnBeforeDay addTarget:self action:@selector(btnClickBeforeDay) forControlEvents:UIControlEventTouchUpInside];
    [self.btnBeforeDay setTitle:@"前一天" forState:UIControlStateNormal];
    self.btnBeforeDay.titleLabel.font = themeFont15;
    [viewBG addSubview:self.btnBeforeDay];
    
    NSString *strToday = [self FirstTimeValue];
    self.btnToday = [[TodaySearchDayButton alloc] initWithStr:strToday leftImageName:@"todaySatificateXHrili" rightImageName:@"todaySatificateXHxiala"];
    self.btnToday.frame = CGRectMake((DeviceWidth-kscaleDeviceWidth(122))/2, kscaleDeviceHeight(12), kscaleDeviceWidth(122), kscaleDeviceHeight(15));
    [self.btnToday addTarget:self action:@selector(btnClickToday) forControlEvents:UIControlEventTouchUpInside];
    [viewBG addSubview:self.btnToday];
    
    self.btnafterDay = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnafterDay.frame = CGRectMake(DeviceWidth-kscaleDeviceWidth(7)-kscaleDeviceWidth(55), kscaleDeviceHeight(12), kscaleDeviceWidth(55), kscaleDeviceHeight(15));
    [self.btnafterDay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnafterDay setTitle:@"后一天" forState:UIControlStateNormal];
    self.btnafterDay.userInteractionEnabled = NO;
    self.btnafterDay.alpha = 0.4;
    self.btnafterDay.titleLabel.font = themeFont15;
    [self.btnafterDay addTarget:self action:@selector(btnClickAfterDay) forControlEvents:UIControlEventTouchUpInside];
    [viewBG addSubview:self.btnafterDay];
    
    self.strTimeToServer = [self FirstIntTimeValueToServer];
    
//    if ([self.todaySearchDayDelegate respondsToSelector:@selector(todaySearchDayView:standardTimeValue:)]) {
//        [self.todaySearchDayDelegate todaySearchDayView:self standardTimeValue:[self FirstIntTimeValueToServer]];
//    }
    
}

- (NSString *)FirstTimeValue{
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月dd日"];
    NSString *returnStr =[dateFormatter stringFromDate:[NSDate date]];
    return returnStr;
}

- (NSString *)FirstIntTimeValueToServer{
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *returnStr =[dateFormatter stringFromDate:[NSDate date]];
    return returnStr;
}

#pragma mark ---处理点击的事件－－－－－
- (void)btnClickToday{
    LSDateNewActionSheet *dateNewActionSheet = [[LSDateNewActionSheet alloc] initWithTitle:@"选择查询日期"];
    [dateNewActionSheet setBlockSelectdDate:^BOOL(NSTimeInterval timeInterval){
       NSString *strDate = [HZDateFormatter returnDateWithTimeInterval:timeInterval];
        NSLog(@"%@",strDate);
        [self updateTodayDateShow:strDate];
        
        NSString *strDateToServer = [HZDateFormatter returnDateWithTimeIntervalToServer:timeInterval];
        [self updateDayAfterShow:strDateToServer];
        
        self.strTimeToServer = strDateToServer;
        if ([self.todaySearchDayDelegate respondsToSelector:@selector(todaySearchDayView:standardTimeValue:)]) {
            [self.todaySearchDayDelegate todaySearchDayView:self standardTimeValue:strDateToServer];
        }
        return true;
    }];
    [dateNewActionSheet setOnCancel:^BOOL{

        return true;
    }];
    [dateNewActionSheet showInView:[self navigationController:self].view];
}
- (void) btnClickBeforeDay{
    int beforDay = [self.strTimeToServer integerValue]-1;
    NSLog(@"%d",beforDay);
    self.strTimeToServer = [NSString stringWithFormat:@"%d",beforDay];
    [self updateDayAfterShow:self.strTimeToServer];
    
    NSString *refreshDate = [self matchYearMonthDay:self.strTimeToServer];
    [self updateTodayDateShow:refreshDate];
    if ([self.todaySearchDayDelegate respondsToSelector:@selector(todaySearchDayView:standardTimeValue:)]) {
        [self.todaySearchDayDelegate todaySearchDayView:self standardTimeValue:self.strTimeToServer];
    }
}

- (void)btnClickAfterDay{
    int afterDay = [self.strTimeToServer integerValue]+1;
    NSLog(@"%d",afterDay);
    self.strTimeToServer = [NSString stringWithFormat:@"%d",afterDay];
    [self updateDayAfterShow:self.strTimeToServer];
    NSString *refreshDate = [self matchYearMonthDay:self.strTimeToServer];
    [self updateTodayDateShow:refreshDate];
    if ([self.todaySearchDayDelegate respondsToSelector:@selector(todaySearchDayView:standardTimeValue:)]) {
        [self.todaySearchDayDelegate todaySearchDayView:self standardTimeValue:self.strTimeToServer];
    }
}

- (void)updateTodayDateShow:(NSString *)strDate{
    self.btnToday.labelTitleNew.text = strDate;
    CGFloat textWidth = [NSString calculateTextWidth:kscaleDeviceHeight(15) Content:strDate font:themeFont15];
    self.btnToday.frame = CGRectMake((DeviceWidth-textWidth-kscaleDeviceWidth(42))/2, kscaleDeviceWidth(12), textWidth, kscaleDeviceHeight(15));
    self.btnToday.imageViewLeft.frame = CGRectMake(kscaleDeviceWidth(5), 0, kscaleDeviceWidth(15), kscaleDeviceHeight(15));
    self.btnToday.labelTitleNew.frame = CGRectMake(kscaleDeviceWidth(25), 0, textWidth, kscaleDeviceHeight(15));
    self.btnToday.imageViewRight.frame = CGRectMake(kscaleDeviceWidth(30)+textWidth, kscaleDeviceHeight(5), kscaleDeviceWidth(12), kscaleDeviceHeight(6));
}

-(void)updateDayAfterShow:(NSString *)strDate{
    if ([strDate isEqualToString:[self FirstIntTimeValueToServer]]) {
        self.btnafterDay.userInteractionEnabled = NO;
        self.btnafterDay.alpha = 0.4;
    }else{
        self.btnafterDay.userInteractionEnabled = YES;
        self.btnafterDay.alpha = 1.0;
    }
}

- (NSString *)matchYearMonthDay:(NSString*)strDate{
    NSString *year = [strDate substringToIndex:4];
    NSString *month = [strDate substringWithRange:NSMakeRange(4, 2)];
    NSString *day = [strDate substringFromIndex:6];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit;
    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    
    NSString *strDateBefore = nil;
    if ([year integerValue]==cmp2.year) {
        strDateBefore = [NSString stringWithFormat:@"%@月%@日",month,day];
    }else{
        strDateBefore = [NSString stringWithFormat:@"%@年%@月%@日",year,month,day];
    }
    return strDateBefore;
}

//获取导航控制器
- (UINavigationController*)navigationController:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController*)nextResponder;
        }
    }
    return nil;
}
@end
