//
//  XSSettingViewController.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/26.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSViewSecondController.h"

@interface XSSettingViewController :XSViewSecondController <UITableViewDelegate,UITableViewDataSource>{
    NSArray *arrayContent;
}
@property (nonatomic, strong)UITableView      *table;
@property (nonatomic, strong)NSMutableArray   *arrayData;

@property (nonatomic, assign)BOOL    isNewVersion;

@end
