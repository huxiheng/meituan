//
//  LeftVCCollectionHeaderView.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/19.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LeftVCCollectionHeaderView.h"

@implementation LeftVCCollectionHeaderView
- (void)initSubviews{
    self.viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, kscaleIphone6DeviceLength(265))];
//    self.viewBG.backgroundColor = [UIColor redColor];
    [self addSubview:self.viewBG];
    
    self.imageviewHeader = [[UIImageView alloc] initWithFrame:CGRectMake((DeviceWidth-kscaleDeviceWidth(95))/2, kscaleDeviceWidth(76), kscaleDeviceWidth(95), kscaleDeviceWidth(95))];
   
    self.imageviewHeader.image = [UIImage imageNamed:@"cebianlantouxiang"];
    self.imageviewHeader.layer.cornerRadius = kscaleDeviceWidth(47.5);
    self.imageviewHeader.layer.masksToBounds = YES;
    self.imageviewHeader.userInteractionEnabled = YES;
    [self.viewBG addSubview:self.imageviewHeader];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeaderClick)];
    tap.cancelsTouchesInView = NO;
    [self.imageviewHeader addGestureRecognizer:tap];
    
    self.labelTitle= [[UILabel alloc] initWithFrame:CGRectMake(0, kscaleDeviceWidth(76)+kscaleDeviceWidth(95)+kscaleDeviceWidth(15), DeviceWidth, kscaleDeviceWidth(17))];
    self.labelTitle.textColor = [UIColor whiteColor];
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    self.labelTitle.font = themeFont17;
    
    [self.viewBG addSubview:self.labelTitle];
}

- (void)reloadDataForView:(id)model{
    self.model = model;
    
    self.labelTitle.text = [LoginUtil loginUserName];
//    NSData *strFilePath = [[NSUserDefaults standardUserDefaults] objectForKey:@"saveFilePath"];
    NSLog(@"%@",((NSString*)self.model));
    
    if (((NSString*)self.model)!=nil || ![((NSString*)self.model) isEqualToString: @"" ] || ((NSString*)self.model)!=NULL) {
        NSArray *arrayUserImages = [NSArray arrayWithContentsOfFile:((NSString*)self.model)];
        for (int i=0; i<arrayUserImages.count; i++) {
            NSDictionary *dic = arrayUserImages[i];
            if ([[LoginUtil loginUserName] isEqualToString:dic[@"userName"]]) {
                self.imageviewHeader.image = [UIImage imageWithData:dic[@"imagedata"]];
                return;
            }
        }
        self.imageviewHeader.image = [UIImage imageNamed:@"cebianlantouxiang"];
    }else{
        self.imageviewHeader.image = [UIImage imageNamed:@"cebianlantouxiang"];
    }
    
    
    
}

- (void)tapHeaderClick{
    if ([_delegateClickHead respondsToSelector:@selector(leftviewController:didSelectHead:)]) {
        [_delegateClickHead leftviewController:self didSelectHead:self.imageviewHeader];
    }
}
@end
