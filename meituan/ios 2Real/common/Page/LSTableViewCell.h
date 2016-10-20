//
//  LSTablViewCell.h
//  Yingcheng
//
//  Created by lessu on 14-2-19.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSTableViewCell : UITableViewCell

@property(nonatomic,copy) NSDictionary *data;

- (CGFloat)heightForData:(NSDictionary *)data;
+ (CGFloat)cellHeight;

@end
