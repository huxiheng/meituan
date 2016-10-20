//
//  TextFieldLimiter.h
//  NipponComment
//
//  Created by lessu on 14-7-18.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextFieldLimiter : NSObject<UITextFieldDelegate,UITextViewDelegate>

@property(nonatomic,assign) NSInteger limit;
@property(nonatomic,assign) id<UITextFieldDelegate,UITextViewDelegate> delegate;
+ (instancetype)limiterWithCount:(NSInteger)limit;
- (instancetype)initWithCount:(NSInteger)limit;

@end
