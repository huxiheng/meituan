//
//  XSMainViewController.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/20.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSViewController.h"
#import "ViewDeck.h"

#import "XSRefreshViewController.h"

@interface XSMainViewController : XSRefreshViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) UIPopoverController* popoverController;

@property (nonatomic, strong)UITableView *table;

@property (nonatomic, strong)NSMutableArray *dataListArray;

@end
