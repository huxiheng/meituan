//
//  TodaySearchDayButton.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/21.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodaySearchDayButton : UIButton
@property (nonatomic, copy)NSString *strLeftImageName;
@property (nonatomic, copy)NSString *strRightImageName;
@property (nonatomic, copy)NSString *strTitle;
@property (nonatomic, strong)UILabel  *labelTitleNew;
@property (nonatomic, strong)UIImageView *imageViewLeft;
@property (nonatomic, strong)UIImageView *imageViewRight;

- (instancetype)initWithStr:(NSString *)str leftImageName:(NSString *)leftImageName rightImageName:(NSString *)rightImageName;

@end
