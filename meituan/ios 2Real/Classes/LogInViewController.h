//
//  LogInViewController.h
//  Xieshi
//
//  Created by Tesiro on 16/7/12.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSViewController.h"

@interface LogInViewController : XSViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UIView    *viewBG;
@property (nonatomic, strong)UIImageView *imageViewBG;

@property (nonatomic, strong)UILabel  *labelTitle;
//@property (nonatomic, strong)UIView   *viewLog;
@property (nonatomic, strong)UITextField *textFieldReportNum;
@property (nonatomic, strong)UITextField *textFieldCheckCode;

@property (nonatomic, strong)UIButton    *buttonSure;
@property (nonatomic, strong)UIButton    *buttonZBar;



@end
