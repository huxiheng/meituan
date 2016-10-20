//
//  XSRemoveCountBindView.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/8.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^blockClickBtn) (NSInteger index);
@interface XSRemoveCountBindView : UIView
@property (nonatomic, strong)UIView   *viewBG;
@property (nonatomic, strong)UILabel  *labelTitle;
@property (nonatomic, strong)UIView   *lineViewTitle;
@property (nonatomic, strong)UILabel  *labelIphoneNum;
@property (nonatomic, strong)UILabel  *labelUserName;
@property (nonatomic, strong)UIView   *lineViewBottomUp;

@property (nonatomic, copy)NSString    *strIphpneNum;
@property (nonatomic, copy)NSString    *strCountName;
@property (nonatomic, copy)blockClickBtn blockClickBtn;
- (instancetype)initWithIphoneNum:(NSString *)number countName:(NSString *)name;
@end
