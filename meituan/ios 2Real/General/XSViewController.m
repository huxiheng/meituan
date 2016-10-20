//
//  XSViewController.m
//  Xieshi
//
//  Created by Tesiro on 16/7/12.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "XSMainViewController.h"

@interface XSViewController ()

@end

@implementation XSViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.navigationController.viewControllers.count==1) {
        self.navigationController.navigationBar.hidden = YES;
    }else{
        self.navigationController.navigationBar.hidden = NO;
    }
    if (self.navigationController.viewControllers.count==1&&[NSStringFromClass([[self.navigationController.viewControllers objectAtIndex:0] class]) isEqualToString:NSStringFromClass([XSMainViewController class])]){
        self.navigationController.navigationBar.hidden = NO;
    }
    if (self.navigationController&&[self.navigationController.viewControllers count]==1) {
//        self.navigationController.interactivePopGestureRecognizer.enabled =YES;
//        [self replaceSystemGesture];
    }
    else {
        self.navigationController.interactivePopGestureRecognizer.enabled =YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setData];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    self.navigationController.fd_interactivePopDisabled = NO;
    self.navigationController.interactivePopGestureRecognizer.delegate=(id<UIGestureRecognizerDelegate>)self;
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    [self setTitleforNavgationVicontroller];
    
    if (self.navigationController.viewControllers.count>1) {
      self.navigationItem.leftBarButtonItem =  [self setbackNavGationBarIterm];
    }else {
        
    }
    
}

- (void)setTitleforNavgationVicontroller {
    self.labelNavTitle = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 160, 44)];
    self.labelNavTitle.text = self.titleForNav;
    self.labelNavTitle.textColor = [UIColor whiteColor];
    self.labelNavTitle.textAlignment = NSTextAlignmentCenter;
    self.labelNavTitle.font = [UIFont systemFontOfSize:15];
    self.navigationItem.titleView = self.labelNavTitle;
    
}

- (UIBarButtonItem *)setbackNavGationBarIterm{
    UIBarButtonItem *leftBarIterm = [[UIBarButtonItem alloc] init];
    UIButton * leftBarButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [leftBarButton setImage:[UIImage imageNamed:@"houtui"] forState:UIControlStateNormal];
    [leftBarButton setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [leftBarButton addTarget:self action:@selector(popNav:) forControlEvents:UIControlEventTouchUpInside];
    [leftBarIterm setCustomView:leftBarButton];
    return leftBarIterm;
}

- (void)popNav:(UIButton *)btn{
    if (self.navigationController.viewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
    }
}

- (void)setData {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setNavLeftItemWith:(NSString *)str andImage:(UIImage *)image {
    if ([self.navigationController.viewControllers count] ==1){
        if ([str isEqualToString:@""])
        {
            UIBarButtonItem *leftItem =[[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
            self.navigationItem.leftBarButtonItem = leftItem;
        }
        else
        {
            UIBarButtonItem *leftItem =[[UIBarButtonItem alloc] initWithTitle:str style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
            self.navigationItem.leftBarButtonItem = leftItem;
        }
    }
}

- (void)setNavRightItemWith:(NSString *)str andImage:(UIImage *)image
{
    if ([str isEqualToString:@""])
    {
        UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    else
    {
        UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithTitle:str style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
        
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}

- (void)setNavRightItems:(NSArray *)arrays {
    NSMutableArray *rightBarButtonItems =[[NSMutableArray alloc] init];
    
    for (NSInteger i=0; i<arrays.count; i++) {
        if (i==0) {
            UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithImage:arrays[i] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
            [rightBarButtonItems addObject:rightItem];
        }
        if (i==1) {
            UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithImage:arrays[i] style:UIBarButtonItemStylePlain target:self action:@selector(rightItem2Click:)];
            [rightBarButtonItems addObject:rightItem];
        }
    }
    self.navigationItem.rightBarButtonItems =rightBarButtonItems;
}

- (void)rightItemClick:(id)sender{
    
}
- (void)rightItem2Click:(id)sender{
    
}
- (void)leftItemClick:(id)sender{
    
}

@end
