//
//  XSImagePickerController.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/20.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSImagePickerController.h"

@implementation XSImagePickerController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTintColor:[UIColor colorWithHexString:KcolorWhite]];
    [self.navigationBar setBarTintColor:[UIColor colorWithRed:41/255.0 green:124/255.0 blue:199/255.0 alpha:1.0]];
    self.navigationBar.translucent =NO;
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationBar.titleTextAttributes =[NSDictionary dictionaryWithObject:[UIColor colorWithHexString:KcolorWhite] forKey:NSForegroundColorAttributeName];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
