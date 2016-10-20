//
//  ProjectViewController.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-26.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "ProjectViewController.h"
//#import "BMapKit.h"
#import "AppDelegate.h"
#import "LSPickerActionSheet.h"
//#import "BMKLocationService.h"
#import "MapProjectTableViewCell.h"
#import "ProjectSearchViewController.h"

@interface ProjectViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *mapContainer;
@property(nonatomic,retain)     BMKMapView* mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *viewHead;
@property(nonatomic,retain)     NSArray *list;
@property(nonatomic,retain)     NSMutableDictionary* titleMap;
@property(nonatomic,retain)     BMKLocationService* locService;
@property(nonatomic,retain)     BMKUserLocation* userLocation;

@property(nonatomic,retain) ProjectSearchViewController *searchViewController;
@property(nonatomic,retain)     NSString *memberCode;
@property(nonatomic,retain)     NSString *hour;
@end

@implementation ProjectViewController
- (void)setData{
    self.titleForNav = @"工程查询";
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [super loadView];
    
    _viewHead.frame = CGRectMake(0, 0, DeviceWidth, kscaleDeviceHeight(50));
    self.buttonDiTu.frame = CGRectMake(0, 0, kscaleIphone5DeviceLength(160), kscaleDeviceHeight(50));
    self.buttonLaterProject.frame = CGRectMake(kscaleIphone5DeviceLength(160), 0, kscaleIphone5DeviceLength(160), kscaleDeviceHeight(50));
    
    _memberCode = @"";
    _hour       = @"4";
    IOS7_LAYOUT_FIX;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"MapProjectTableViewCell" bundle:nil] forCellReuseIdentifier:@"mapProjectCell"];
    _userLocation = nil;
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
//    _mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
//    [_mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];

    //上海经纬度
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(31.14, 121.30)];
    [_mapView setZoomLevel:11];
    [_mapContainer addSubview:_mapView];
//    self.title = @"工程查询";

    //设置定位精确度，默认：kCLLocationAccuracyBest
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:100.f];
    
    //初始化BMKLocationService  
    _locService = [[BMKLocationService alloc]init];  
    _locService.delegate = self;  
    //启动LocationService  
    [_locService startUserLocationService];  
    [self dataRequest];
    
    [self mapButtonDidPress:nil];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_navigation_menu"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonDidPress:)];
    self.navigationItem.leftBarButtonItem = barButton;

    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_navigation_search"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonDidPress:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    _buttonDiTu.selected = YES;
}

- (void)dataRequest{
    NSDictionary *params = @{
                             @"Hour"        : _hour,
                             @"MemberCode"  : _memberCode,
                             @"Token" : [LoginUtil token]
                             };
    APIConnection *connection = [[CommonAPI sharedInstance]connectionWithApiName:APIMETHOD_STAKE_List params:params];
    [connection setOnSuccess:^(id result) {
        [self updateUI:ARRAY_EMPTY_IF_NOT( result[kAPIConnectionStandartDataKey] )];
        [SVProgressHUD dismiss];
    }];
    [connection setOnFailed:^(NSError *error) {
        NSString *errorDescription = [error localizedDescription];
        [SVProgressHUD dismissWithError:STRING_FORMAT(@"%@",errorDescription) afterDelay:2.5f];
    }];
    [SVProgressHUD show];
    [connection startAsynchronous];
    
    
    
}
- (void)leftBarButtonDidPress:(UIBarButtonItem *)sender{
    [APP_DELEGATE.rootMainViewController showLeft];
}

- (void)rightBarButtonDidPress:(UIBarButtonItem *)sender{
//    if (    _searchViewController == NULL) {
//        _searchViewController = [[ProjectSearchViewController alloc]init];
//    }
//    weakAlias(bSelf, self);
//    [_searchViewController setOnComplete:^(NSString *memberCode, NSString *hour) {
//        [bSelf onCompleteWithMemberCode:memberCode andHour:hour];
//        [bSelf.navigationController popViewControllerAnimated:YES];
//    }];
//    [self.navigationController pushViewController:_searchViewController animated:YES];
    
    
          ProjectSearchViewController  *searchViewController2 = [[ProjectSearchViewController alloc]init];
    
        weakAlias(bSelf, self);
        [searchViewController2 setOnComplete:^(NSString *memberCode, NSString *hour) {
            [bSelf onCompleteWithMemberCode:memberCode andHour:hour];
            [bSelf.navigationController popViewControllerAnimated:YES];
        }];
        [self.navigationController pushViewController:searchViewController2 animated:YES];

}
- (void)onCompleteWithMemberCode:(NSString *)memberCode andHour:(NSString *)hour
{
    _memberCode = memberCode;
    _hour = hour;
    [self dataRequest];
    
}
- (void)viewWillAppear:(BOOL)animated    
{    
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];

    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放    
}    
- (void)viewWillDisappear:(BOOL)animated    
{    
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];    
    _mapView.delegate = nil; // 不用时，置nil    
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    _mapView.frame = _mapContainer.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)updateUI:(NSArray *)data{
    _list = data;
    [_mapView removeAnnotations:_mapView.annotations];
//    _data = data;
    // 添加一个PointAnnotation    
    [data enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop) {
        if ([obj[@"map"] boolValue] == false) {
            return ;
        }
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];    
        CLLocationCoordinate2D coor; 
        coor.latitude = [obj[@"x"] floatValue];   
        coor.longitude = [obj[@"y"] floatValue];
        annotation.coordinate = coor;    
        annotation.title = obj[@"stakeName"] == nil ? @" ":obj[@"stakeName"];
//        annotation.title = @" ";
        [_mapView addAnnotation:annotation];
    }];
    [_tableView reloadData];

}

- (void)navigation:(NSString *)title lat:(float) lat lng:(float) lng{

    [LSDialog showDialogWithTitle:NULL message:title confirmText:@"导航" confirmCallback:^{
        if(_userLocation){
            //latitude-纬度  longitude-经度 
            NSString *stringURL = [NSString stringWithFormat:@"baidumap://map/direction?origin=%f,%f&destination=%f,%f&mode=driving",
                                   _userLocation.location.coordinate.latitude,_userLocation.location.coordinate.longitude,
                                   lat,lng]; 
            NSURL *url = [NSURL URLWithString:stringURL]; 
            if (![[UIApplication sharedApplication] openURL:url]) { 
                [SVProgressHUD showErrorWithStatus:@"您还未安装百度地图"];
                [[UIApplication sharedApplication] openURL:url];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"正在定位，请稍后再试"];
        }
    } cancelText:@"取消" cancelCallback:^{
        
    }];
}

#pragma mark - IBAction
- (IBAction)mapButtonDidPress:(id)sender {
//    [_mapView viewWillAppear]; 
    APP_DELEGATE.rootMainViewController.enableGesture = false;
    _mapContainer.hidden = false;
    _tableView.hidden = true;
    
    _buttonDiTu.selected = false;
    _buttonLaterProject.selected = false;
    ((UIButton *)sender).selected  = true;

}
- (IBAction)recentProjectButtonDidPress:(id)sender {
//    [_mapView viewWillDisappear]; 
    APP_DELEGATE.rootMainViewController.enableGesture = true;
    _mapContainer.hidden = true;
    _tableView.hidden = false;
    [_tableView reloadData];
    
    _buttonDiTu.selected = false;
    _buttonLaterProject.selected = false;
    ((UIButton *)sender).selected  = true;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _list.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *data = _list[indexPath.row];
    //    _cellTitleLabel.text = data[@"stakeName"];
    NSArray *arrayTitle = [data[@"stakeName"] componentsSeparatedByString:@","];
    [arrayTitle objectAtIndex:1];
    NSString *stringProjectName = [NSString stringWithFormat:@"工程名称：%@",[arrayTitle objectAtIndex:1]];
    

    CGFloat heightTitle = [NSString calculateTextHeight:kscaleIphone5DeviceLength(290) Content:stringProjectName font:themeFont14];
    heightTitle= heightTitle+5>25?heightTitle:14;
//    self.VviewBottom.frame = CGRectMake(0, 21+heightTitle+35+35, DeviceWidth, 35);
    return kscaleDeviceHeight(21)+heightTitle+kscaleDeviceHeight(35)+ kscaleDeviceHeight(35);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"mapProjectCell";
    MapProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.data = _list[indexPath.row];
    
    if (indexPath.row%2 ==0) {
        cell.viewProjectName.backgroundColor = [UIColor colorWithRed:234.0/255.0 green:234.0/255.0 blue:234.0/255.0 alpha:1.0];
        cell.viewProjectNumber.backgroundColor = [UIColor colorWithRed:234.0/255.0 green:234.0/255.0 blue:234.0/255.0 alpha:1.0];
        cell.VviewBottom.backgroundColor = [UIColor colorWithRed:234.0/255.0 green:234.0/255.0 blue:234.0/255.0 alpha:1.0];
    }else{
        cell.viewProjectName.backgroundColor = [UIColor whiteColor];
        cell.viewProjectNumber.backgroundColor =[UIColor whiteColor];
        cell.VviewBottom.backgroundColor =[UIColor whiteColor];
    }
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *data = _list[indexPath.row];
    [self navigation:data[@"stakeName"] lat:[data[@"x"] floatValue] lng:[data[@"y"] floatValue]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - BMKMapViewDelegate
// Override  
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation  
{  
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {  
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];     
        newAnnotationView.pinColor = BMKPinAnnotationColorRed;
        
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        newAnnotationView.canShowCallout = false;
        
        
        return newAnnotationView;     
    }  
    return nil;  
}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    NSString* message = LS_CAST(BMKPointAnnotation*,  view.annotation).title;    
    CLLocationCoordinate2D coord = LS_CAST(BMKPointAnnotation*,  view.annotation).coordinate;
    [self navigation:message lat:coord.latitude lng:coord.longitude];
//    view.enabled = NO;
    view.selected = NO;
}

-(void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view{
    
}

-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//    NSLog(@"当前位置%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
      _userLocation = userLocation;
}


#pragma mark - BMKLocationServiceDelegate
//实现相关delegate 处理位置信息更新  
//处理方向变更信息  
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation  
{  
    //NSLog(@"heading is %@",userLocation.heading);  
}  
//处理位置坐标更新  
//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation  
//{  
//    _userLocation = userLocation;
//}
@end
