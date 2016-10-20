//
//  TodayStatisticsMapVC.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/10/10.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BMapKit.h"
#import "PopoverViewController.h"
#import "PopoverAnimator.h"
#import "XSPresentationController.h"
#import "CllocationUserVC.h"
#import <CoreLocation/CoreLocation.h>

typedef void(^blockUserLocation) (CLLocation *location);//处理定位

@protocol GetSearchDistanceAndUserLocationDelegate;

@interface TodayStatisticsMapVC : UIViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,CLLocationManagerDelegate>{
    
    CLLocationManager *locationM;
}
@property (nonatomic, strong)BMKMapView     *mapView;
@property(nonatomic,retain)     BMKLocationService* locService;

@property(nonatomic, strong)PopoverAnimator *popoverAnimator;//处理转场动画的代理
@property (nonatomic, strong)CLLocation    *locationUser;//用户的位置信息
@property (nonatomic,copy)NSString *textProjectName;//搜索的工地名称
@property (nonatomic,copy)NSString *distanceSearch;//搜索的距离

@property (nonatomic, assign)int indexLevel;//放大和缩放的比例
@property (nonatomic, copy)NSArray  *arrayDataForAnotation;//大头针的数据数组

@property (nonatomic,assign)id<GetSearchDistanceAndUserLocationDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame;

@end

@protocol GetSearchDistanceAndUserLocationDelegate <NSObject>

-(void)TodayStatistics:(TodayStatisticsMapVC*)todayStatisticsMapVC distance:(NSString *)distance clocation:(CLLocation *)clocation;
-(void)todayStatistics:(TodayStatisticsMapVC *)todayStatisticsMapVC addObserverUserLocation:(CLLocation *)location;
-(void)todayStatistics:(TodayStatisticsMapVC *)todayStatisticsMapVC textProject:(NSString *)searchProjectName distance:(NSString*)distance clocation:(CLLocation*)location;

@end

