//
//  LSDateNewActionSheet.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/29.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "LSActionSheet.h"
typedef BOOL (^BlockSelectDate) (NSTimeInterval timeInterval);

@interface LSDateNewActionSheet : LSActionSheet
@property (nonatomic, copy)BlockSelectDate      blockSelectdDate;
- (id)initWithTitle:(NSString *)title;

@end
