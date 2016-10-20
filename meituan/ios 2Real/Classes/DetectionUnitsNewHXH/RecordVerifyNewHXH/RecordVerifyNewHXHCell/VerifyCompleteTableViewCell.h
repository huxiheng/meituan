//
//  ApplyTableViewCell.h
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-27.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerifyCompleteTableViewCell : UITableViewCell
@property(nonatomic,strong) NSDictionary *data;
@property (weak, nonatomic) IBOutlet UILabel *cellSampleIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellConsignLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellDataLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellAppDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellVerifyLabel;

@property (weak, nonatomic) IBOutlet UIView *viewVerify;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewVerifyLine;

@property (weak, nonatomic) IBOutlet UIView *viewSampleID;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewSampleIDLine;

@property (weak, nonatomic) IBOutlet UIView *viewConsign;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewConsignLine;

@property (weak, nonatomic) IBOutlet UIView *viewData;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewDataLine;

@property (weak, nonatomic) IBOutlet UIView *viewAPPData;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewAPPDataLine;

@property (weak, nonatomic) IBOutlet UIView *viewBottom;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewBottomLine;

+ (CGFloat)cellHeight;
@end
