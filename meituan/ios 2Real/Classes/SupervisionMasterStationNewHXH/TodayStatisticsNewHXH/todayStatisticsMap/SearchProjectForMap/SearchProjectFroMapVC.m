//
//  SearchProjectFroMapVC.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/10/17.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "SearchProjectFroMapVC.h"

@interface SearchProjectFroMapVC ()
@property (nonatomic,strong)UITextField *textfieldSearch;
@property (nonatomic,copy)NSMutableArray *arrayData;
@end

@implementation SearchProjectFroMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setSubViewForNav];
    self.arrayData = [NSMutableArray array];
}

-(void)setSubViewForNav{
    UIView *viewNav = [[UIView alloc] initWithFrame:CGRectMake(0, 20, DeviceWidth, 44)];
    viewNav.backgroundColor = [UIColor colorWithRed:41/255.0 green:124/255.0 blue:199/255.0 alpha:1.0];
    [self.view addSubview:viewNav];
    
    UIButton * leftBarButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 24, 24)];
    [leftBarButton setImage:[UIImage imageNamed:@"houtui"] forState:UIControlStateNormal];
    [leftBarButton addTarget:self action:@selector(popNavClick:) forControlEvents:UIControlEventTouchUpInside];
    [viewNav addSubview:leftBarButton];
    
    UIView *viewTextField = [[UIView alloc] initWithFrame:CGRectMake(44,kscaleIphone6DeviceHeight(10), DeviceWidth-44-10, 44-kscaleIphone6DeviceHeight(20))];
    viewTextField.backgroundColor = [UIColor whiteColor];
    [viewNav addSubview:viewTextField];
    
    UIImageView *imageTitle = [[UIImageView alloc] initWithFrame:CGRectMake(5, (34-kscaleIphone6DeviceHeight(20))/2, 10, 10)];
    imageTitle.image = [UIImage imageNamed:@"GLYTodayStatisticssousuotubiao"];
    [viewTextField addSubview:imageTitle];
    
    self.textfieldSearch = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, DeviceWidth-44-10-20, 44-kscaleIphone6DeviceHeight(20))];
    [viewTextField addSubview:self.textfieldSearch];
    self.textfieldSearch.clearButtonMode =UITextFieldViewModeAlways;
    self.textfieldSearch.delegate = self;
    self.textfieldSearch.clearsOnBeginEditing = YES;
    self.textfieldSearch.returnKeyType = UIReturnKeyDone;
    [self.textfieldSearch becomeFirstResponder];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, DeviceWidth, DeviceHeight-64) style:UITableViewStylePlain];
//    table.delegate = self;
//    table.dataSource = self;
    [self.view addSubview:table];
}

#pragma mark ----点击事件－－－－
-(void)popNavClick:(UIButton *)btn{
    [self.textfieldSearch resignFirstResponder];
    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma mark---UITABLEviewDelegate----


#pragma mark ---uitextfieldDelegate----
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textfieldSearch resignFirstResponder];
    [self dismissViewControllerAnimated:NO completion:nil];
    if (self.textfieldSearch.text!=nil || ![self.textfieldSearch.text isEqualToString:@""]) {
        if ([self.delegate respondsToSelector:@selector(searchProjectFroMapVC:textSearch:)]) {
            [self.delegate searchProjectFroMapVC:self textSearch:self.textfieldSearch.text];
        }
    }
    return YES;
}
@end
