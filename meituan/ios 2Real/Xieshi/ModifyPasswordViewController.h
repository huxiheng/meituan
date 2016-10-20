//
//  ModifyInfoViewController.h
//  Youxian100
//
//  Created by zxg on 13-4-1.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyPasswordViewController : UIViewController


@property (nonatomic, copy) void (^completeBlock)(NSString * newPassword);
@property (nonatomic, retain) NSString * userName;


@end
