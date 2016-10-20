//
//  CllocationUser.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/10/13.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^blockUserLocation) (CLLocation *location);
@interface CllocationUserVC : UIViewController<CLLocationManagerDelegate>{
    
    CLLocationManager *locationM;
}

@property (nonatomic,strong)blockUserLocation blockUserLocation;
@property (nonatomic, strong)CLLocation  *locationUser;
@end
