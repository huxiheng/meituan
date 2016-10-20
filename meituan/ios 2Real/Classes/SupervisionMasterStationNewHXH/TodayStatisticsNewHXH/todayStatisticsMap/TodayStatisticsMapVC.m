//
//  TodayStatisticsMapVC.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/10/10.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "TodayStatisticsMapVC.h"
#import <CoreLocation/CoreLocation.h>
#import "SearchProjectFroMapVC.h"

@interface TodayStatisticsMapVC ()<GetSearchProjectNameDelegate>{
    UIButton *btnSearch;
}

@end

@implementation TodayStatisticsMapVC
#pragma mark ---系统方法
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithNibName:nil bundle:nil]) {
        [self setSubViewsForUserLocation];
        [self setSubViews];
    }
    return self;
}

-(instancetype)init{
    if (self==[super init]) {
        [self setSubViewsForUserLocation];
        [self setSubViews];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self==[super initWithCoder:aDecoder]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [super loadView];
//    [self setSubViews];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _locService.delegate = self;
    [locationM startUpdatingLocation];
}

-(void)viewWillDisappear:(BOOL)animated{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _locService.delegate = nil;
    [locationM stopUpdatingLocation];
    [super viewWillDisappear:animated];
}

#pragma mark:-- 布置view的ui界面
-(void)setSubViews{
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-kscaleIphone6DeviceHeight(50)-64)];
    [self.view addSubview:_mapView];
    self.mapView.showsUserLocation = YES;
    [_mapView setZoomLevel:11];
    self.indexLevel = 11;
        //设置定位精确度，默认：kCLLocationAccuracyBest
        [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    CLLocationCoordinate2D clocation2D=self.locationUser?self.locationUser.coordinate:CLLocationCoordinate2DMake(31.14, 121.30);
        [_mapView setCenterCoordinate:clocation2D];
        //指定最小距离更新(米)，默认：kCLDistanceFilterNone
        [BMKLocationService setLocationDistanceFilter:100.f];
        _mapView.showsUserLocation = NO;
        _mapView.userTrackingMode = BMKUserTrackingModeNone;
        _mapView.showsUserLocation = YES;
        _mapView.showMapScaleBar = YES;
        _mapView.mapScaleBarPosition = CGPointMake( kscaleDeviceWidth(50) , DeviceHeight-kscaleIphone6DeviceHeight(50)-64-kscaleIphone6DeviceHeight(50));
    
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    //以下_mapView为BMKMapView对象
    _mapView.showsUserLocation = YES;//显示定位图层
    
    //处理转场动画的代理
    _popoverAnimator = [[PopoverAnimator alloc] init];
    
    ButtonTitleLeftImageRight *btn = [[ButtonTitleLeftImageRight alloc] initWithFrame:CGRectMake(DeviceWidth-kscaleDeviceWidth(85), kscaleIphone6DeviceLength(60), kscaleDeviceWidth(75), kscaleIphone6DeviceLength(29)) title:@"附近：3公里" font:themeFont9 textColor:kc00_3385FF];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(kiloMeterTitleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn bringSubviewToFront:_mapView];
    [self.view addSubview:btn];
    
    //定义地图的缩放按钮
    NSArray *arrayDiJI = @[@"GLYTodaystaticsticsjiadianji",@"GLYStaticsjiandianji"];
    NSArray *arrayWuXiao = @[@"GLYStatisTicsjiawuxiao",@"GLYStaticsticsjianwuxiao"];
    for (int i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(DeviceWidth- kscaleDeviceWidth(50), (DeviceHeight- 64-kscaleIphone6DeviceHeight(50)-kscaleDeviceHeight(101))+kscaleDeviceWidth(41)*i, kscaleDeviceWidth(40), kscaleDeviceWidth(40));
        [button setBackgroundImage:[UIImage imageNamed:arrayWuXiao[i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:arrayDiJI[i]] forState:UIControlStateHighlighted];
        button.tag = 20+i;
        [button addTarget:self action:@selector(buttonClickAddOrJian:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    //改变地图的样式
    UIButton *btnMPType = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMPType.frame = CGRectMake(kscaleDeviceWidth(10), DeviceHeight-kscaleIphone6DeviceHeight(50)-64-kscaleDeviceWidth(50)+kscaleDeviceWidth(10), kscaleDeviceWidth(20), kscaleDeviceWidth(20));
    [btnMPType setBackgroundImage:[UIImage imageNamed:@"GLYStatisticsdizhi"] forState:UIControlStateNormal];
    btnMPType.selected = NO;
    [btnMPType addTarget:self action:@selector(switchMPType:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnMPType];
    
    btnSearch= [UIButton buttonWithType:UIButtonTypeCustom];
    btnSearch.frame = CGRectMake(kscaleDeviceWidth(10), kscaleDeviceWidth(10), DeviceWidth-kscaleDeviceWidth(20), kscaleIphone6DeviceHeight(39));
    btnSearch.layer.borderWidth = 1;
    btnSearch.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [btnSearch setImage:[UIImage imageNamed:@"GLYTodayStatisticssousuotubiao"] forState:UIControlStateNormal];
    [btnSearch setTitle:@"搜索工地名称" forState:UIControlStateNormal];
    [btnSearch setBackgroundColor:[UIColor whiteColor]];
    btnSearch.titleLabel.font = themeFont12;
    [btnSearch setTitleColor:[UIColor colorWithHexString:kc00_7F7F7F] forState:UIControlStateNormal];
    [btnSearch addTarget:self action:@selector(btnClickSearch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSearch];
}

-(void)setArrayDataForAnotation:(NSArray *)arrayDataForAnotation{
    [_mapView removeAnnotations:_mapView.annotations];
    //    _data = data;
    // 添加一个PointAnnotation
    [arrayDataForAnotation enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop) {
        if ([obj[@"ProjectCoordinates"] isEqualToString:@""]) {
            return ;
        }
        NSArray *arr = [obj[@"ProjectCoordinates"] componentsSeparatedByString:@","];
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = [arr[1] floatValue];
        coor.longitude = [arr[0] floatValue];
        annotation.coordinate = coor;
        annotation.title = obj[@"ProjectName"] == nil ? @" ":obj[@"ProjectName"];
        //        annotation.title = @" ";
        [_mapView addAnnotation:annotation];
    }];
}

#pragma mark ----BMKLocationDelegate-----
/**
 *地图区域改变完成后会调用此接口
 *@param mapview 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    self.indexLevel = mapView.zoomLevel;
    
}
//当选中一个annotation views时，调用此接口
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    NSLog(@"选中一个annotation views:%f,%f",view.annotation.coordinate.latitude,view.annotation.coordinate.longitude);
}
//当取消选中一个annotation views时，调用此接口
- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view{
    NSLog(@"取消选中一个annotation views");
}
//当mapView新添加annotation views时，调用此接口
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    NSLog(@"mapView新添加annotation views");
}
//当点击annotation view弹出的泡泡时，调用此接口
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{
    NSLog(@"点击annotation view弹出的泡泡");
}
//拖动annotation view时view的状态变化
- (void)mapView:(BMKMapView *)mapView annotationView:(BMKAnnotationView *)view didChangeDragState:(BMKAnnotationViewDragState)newStatefromOldState:(BMKAnnotationViewDragState)oldState
{
    NSLog(@"动annotation view时view的状态变化");
}
//- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation{
////在这个委托中实现如下代码
//UIView *viewForImage=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 132, 64)];
//UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 32, 64)];
//[imageview setImage:[UIImage imageNamed:@"车位置.png"]];
//[viewForImage addSubview:imageview];
//
//UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(32, 0, 100, 64)];
//label.text=@"陈双超";
//label.backgroundColor=[UIColor clearColor];
//[viewForImage addSubview:label];
//    return viewForImage;
//}

-(UIImage *)getImageFromView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
#pragma mark - BMKLocationServiceDelegate
/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
    self.locationUser = userLocation.location;
    
}
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    [_mapView updateLocationData:userLocation];
    self.locationUser = userLocation.location;
    
}
#pragma mark --- 处理点击事件
-(void)kiloMeterTitleBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    _popoverAnimator.button = btn;
    
    //创建弹出的控制器
    PopoverViewController *popoverVC = [[PopoverViewController alloc] init];
    dpBlockSelf;
    popoverVC.blockClickIndexPath = ^(NSString * title){
        _self.distanceSearch = title;
        NSString *text =[NSString stringWithFormat:@"附近：%@公里",title];
        [btn setTitle:text forState:UIControlStateNormal];
        [_self calculateTitleWidthFotBtn:text btn:btn];
        if ([_self.delegate respondsToSelector:@selector(todayStatistics:textProject:distance:clocation:)]) {
//            [_self.delegate TodayStatistics:self distance:title clocation:_self.locationUser];
            [_self.delegate todayStatistics:self textProject:self.textProjectName!=nil?self.textProjectName:@"" distance:title clocation:_self.locationUser];
        }
    };
    //设置转场代理
    popoverVC.transitioningDelegate = _popoverAnimator;
    
    //设置控制器的modal样式
    popoverVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:popoverVC animated:YES completion:nil];
}

-(void)calculateTitleWidthFotBtn:(NSString *)title btn:(UIButton*)btn{
    CGFloat width = [NSString calculateTextWidth:kscaleIphone6DeviceHeight(29) Content:title font:themeFont9];
    CGFloat btnWidth = btn.imageView.frame.size.width+width;
    btn.frame = CGRectMake(DeviceWidth-kscaleDeviceWidth(10)-btnWidth-5, kscaleIphone6DeviceHeight(60), btnWidth+5, kscaleIphone6DeviceHeight(29));
}
-(void)buttonClickAddOrJian:(UIButton*)btn{
    
    CLLocationCoordinate2D clocation2D=self.locationUser?self.locationUser.coordinate:CLLocationCoordinate2DMake(31.14, 121.30);
    [_mapView setCenterCoordinate:clocation2D];
    
    switch (btn.tag) {
        case 20:{
            _indexLevel++;
            if (_indexLevel>18) {
                return;
            }
            [_mapView setZoomLevel:_indexLevel];
           break;
        }
            
        case 21:{
            _indexLevel--;
            if (_indexLevel<3) {
                return;
            }
            [_mapView setZoomLevel:_indexLevel];
            break;
        }
            
        default:
            break;
    }
    
}
-(void)switchMPType:(UIButton*)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        _mapView.buildingsEnabled = YES;
        _mapView.overlooking = -30;
        _mapView.forceTouchEnabled = YES;
    }else{
       _mapView.overlooking = 0;
    }
    
}

-(void)btnClickSearch:(UIButton *)btn{
    SearchProjectFroMapVC *searchProjectVC = [[SearchProjectFroMapVC alloc] init];
    searchProjectVC.delegate = self;
    
//    [[self viewControllerForFather].navigationController pushViewController:searchProjectVC animated:NO];
    [[self viewControllerForFather] presentViewController:searchProjectVC animated:NO completion:nil];
}
- (UIViewController*)viewControllerForFather {
    for (UIView* next = [self.view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
#pragma mark ---GetSearchProjectNameDelegate--
-(void)searchProjectFroMapVC:(SearchProjectFroMapVC *)searchProjectForVC textSearch:(NSString *)text{
    self.textProjectName = text;
    if (![text isEqualToString:@""]) {
        [btnSearch setTitle:text forState:UIControlStateNormal];
    }else{
        [btnSearch setTitle:@"搜索工地名称" forState:UIControlStateNormal];
    }
    
    if ([self.delegate respondsToSelector:@selector(todayStatistics:textProject:distance:clocation:)]) {
        //            [_self.delegate TodayStatistics:self distance:title clocation:_self.locationUser];
        [self.delegate todayStatistics:self textProject:text distance:self.distanceSearch!=nil?self.distanceSearch:@"3" clocation:self.locationUser];
    }
    
}
#pragma mark ---定位用户的当前信息－－－－
-(void)setSubViewsForUserLocation{
    
    locationM = [[CLLocationManager alloc] init];
    locationM.delegate = self;
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
        //        [locationM requestAlwaysAuthorization];
        [locationM requestWhenInUseAuthorization];
//        if ([[UIDevice currentDevice].systemVersion floatValue]>=9.0) {
//            locationM.allowsBackgroundLocationUpdates = YES;
//            
//        }
    }
    locationM.distanceFilter = 100;
    locationM.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    //    if ([[UIDevice currentDevice].systemVersion floatValue]>=9.0) {
//        [locationM requestLocation];
//    }else{
        [locationM startUpdatingLocation];
        [locationM startMonitoringSignificantLocationChanges];
//    }
}
#pragma cllocationManagerdelegate ---
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *newLocation = [locations lastObject];
    if ([self.delegate respondsToSelector:@selector(todayStatistics:textProject:distance:clocation:)]) {
        //            [_self.delegate TodayStatistics:self distance:title clocation:_self.locationUser];
        [self.delegate todayStatistics:self textProject:@"" distance:self.distanceSearch!=nil?self.distanceSearch:@"3" clocation:newLocation];
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    if ([self.delegate respondsToSelector:@selector(todayStatistics:textProject:distance:clocation:)]) {
        //            [_self.delegate TodayStatistics:self distance:title clocation:_self.locationUser];
        [self.delegate todayStatistics:self textProject:@"" distance:self.distanceSearch!=nil?self.distanceSearch:@"3" clocation:nil];
    }
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"用户没有决定");
            
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"受限制");
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"前台授权");
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"前后台授权");
            break;
        case kCLAuthorizationStatusDenied:
            if ([CLLocationManager locationServicesEnabled]) {
                [LSDialog showAlertWithTitle:@"提示" message:@"请打开在‘设置>隐私>检测管理的定位服务’" callBack:nil];
                
            }else{
                [LSDialog showAlertWithTitle:@"提示" message:@"请打开在‘设置>隐私>定位服务’" callBack:nil];
            }
            self.locationUser=nil;
            [manager startUpdatingLocation];
            break;
            
        default:
            NSLog(@"none");
            break;
    }
}
@end
