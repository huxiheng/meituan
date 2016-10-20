//
//  UnqualifiedSearchViewController.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-26.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "LSFormTableViewController.h"
typedef enum{
    UnqualifiedSearchViewControllerSample,
    UnqualifiedSearchViewControllerProject,
}UnqualifiedSearchViewControllerType;
@interface UnqualifiedSearchViewController : LSFormTableViewController
@property(nonatomic,assign)UnqualifiedSearchViewControllerType type;

@end
