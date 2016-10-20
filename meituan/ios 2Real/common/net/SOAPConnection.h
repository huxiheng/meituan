//
//  SOAPConnection.h
//  MobilePos
//
//  Created by lessu on 14-3-21.
//  Copyright (c) 2014年 lessu. All rights reserved.
//

#import "APIConnection.h"

@interface SOAPConnection : APIConnection
@property(nonatomic,retain) NSString *soapActionUrl;
@property(nonatomic,retain) NSString *soapAction;
@end
