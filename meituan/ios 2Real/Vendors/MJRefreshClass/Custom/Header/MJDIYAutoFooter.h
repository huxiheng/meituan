//
//  MJDIYAutoFooter.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/13.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJRefreshAutoFooter.h"
#import "MJRefreshBackFooter.h"

@interface MJDIYAutoFooter : MJRefreshBackFooter
@property (strong, nonatomic) UILabel *labelStatusMessage;
@property (strong, nonatomic) UIImageView *imageLoading;
@end
