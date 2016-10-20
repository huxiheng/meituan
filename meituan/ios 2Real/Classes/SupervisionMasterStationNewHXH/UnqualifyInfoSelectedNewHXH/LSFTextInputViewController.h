//
//  TextInputViewController.h
//  Youxian100
//
//  Created by Lessu on 13-4-2.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSFTextInputViewController : XSViewSecondController{
    void (^_onComplete)(NSString *text);
}
@property (retain, nonatomic)   IBOutlet UITextView *inputView;
@property (retain, nonatomic)   NSString *placeHoldText;
@property (nonatomic , retain)  NSString *text;
@property (nonatomic,copy) void (^onComplete)(NSString *text);
- (id)initWithOnCompleteBlock:(void (^)(NSString *text))onComplete;
- (id)initWithString: (NSString *)text OnCompleteBlock:(void (^)(NSString *text))onComplete;
@end
