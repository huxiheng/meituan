//
//  TodaySearchDayView.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/21.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodaySearchDayButton.h"

@protocol TodayStatisticsStandardTimeDelegate;

@interface TodaySearchDayView : UIView
@property (nonatomic, strong)UIButton *btnBeforeDay;
@property (nonatomic, strong)UIButton *btnafterDay;
@property (nonatomic, strong)TodaySearchDayButton *btnToday;
@property (nonatomic, assign)id<TodayStatisticsStandardTimeDelegate>  todaySearchDayDelegate;
@property (nonatomic, copy)NSString  *strTimeToServer;

@end

@protocol TodayStatisticsStandardTimeDelegate <NSObject>

- (void)todaySearchDayView:(TodaySearchDayView *)todaySearchDayView standardTimeValue:(NSString *)standardTime;

@end