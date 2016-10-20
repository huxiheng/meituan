//
//  VerifyFilterViewController.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 15-1-6.
//  Copyright (c) 2015年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSFormTableViewController.h"
typedef enum{
    FilterViewControllerTypeApply  = 0,
    FilterViewControllerTypeVerify = 1

}FilterViewControllerType;
@interface VerifyFilterViewController : LSFormTableViewController
@property(nonatomic) FilterViewControllerType type;
@property(nonatomic,copy) void(^onComplete)(NSString *kindId,NSString *itemId,BOOL isCompletedRecord,NSString *text);

- (instancetype)initWithtype:(FilterViewControllerType )type;
@end
