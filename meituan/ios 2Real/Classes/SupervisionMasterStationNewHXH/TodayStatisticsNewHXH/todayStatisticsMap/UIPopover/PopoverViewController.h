//
//  PopoverViewController.h
//  DItuProjectText
//
//  Created by Tesiro on 16/10/11.
//  Copyright © 2016年 Tesiro. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^blockClickIndexPath) (NSString * title);
@interface PopoverViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,copy)blockClickIndexPath blockClickIndexPath;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end
