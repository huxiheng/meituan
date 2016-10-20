//
//  BuildPhoneNumView.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/18.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^blockClickGetCode) (NSString *str);
typedef void(^blockClickLogIn) (NSString *str1,NSString *str2);

@interface BuildPhoneNumView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UIView           *viewBG;
@property (nonatomic, strong)UIScrollView     *viewScrollView;

@property (nonatomic, strong)UIView           *viewScrollBG;
@property (nonatomic, strong)UITextField      *textFieldPhoneNum;
@property (nonatomic, strong)UITextField      *textFieldCode;
@property (nonatomic, strong)UIButton         *btnCode;

@property (nonatomic, strong)UIButton         *btnLogIn;

@property (nonatomic, strong)blockClickGetCode  blockClickGetCode;
@property (nonatomic, strong)blockClickLogIn    blockClickLogIn;

@property (nonatomic, strong)UITableView       *table;

@end
