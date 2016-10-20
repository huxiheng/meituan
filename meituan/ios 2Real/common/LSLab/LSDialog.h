//
//  LSDialog.h
//  xiaowei
//
//  Created by Lessu on 12-11-28.
//
// v2.0 arc version
// v2.1 fix not dismissed bug in IOS7

#import <UIKit/UIKit.h>
typedef void(^LSDialogCallback)(void);
typedef enum _LSDialogType {
    LSDialogDefault =0,
    LSDialogAlert  ,
    LSDialogDialog ,
    LSDialogType0
} LSDialogType;

@interface LSDialog : UIAlertView<UIAlertViewDelegate>
{
    LSDialogType        _dialogType;
    LSDialogCallback    _cancelCallback;
    LSDialogCallback    _confirmCallback;
}
@property(nonatomic,copy) LSDialogCallback cancelCallback;
@property(nonatomic,copy) LSDialogCallback confirmCallback;

- (id)initAlertWithTitle:(NSString*)title message:(NSString *)message callBack:(LSDialogCallback)callback;
- (id)initDialogWithTitle:(NSString*)title message:(NSString *)message confirmText:(NSString*) confirmText confirmCallback:(LSDialogCallback) confirmCallback cancelText:(NSString *) cancelText cancelCallback:(LSDialogCallback) cancelCallback;

+ (void)showMessage:(NSString *) message;
+ (void)showAlertWithTitle:(NSString*)title message:(NSString *)message callBack:(LSDialogCallback)callback;
+ (void)showDialogWithTitle:(NSString*)title message:(NSString *)message                confirmText:(NSString*) confirmText confirmCallback:(LSDialogCallback) confirmCallback                 cancelText:(NSString *) cancelText cancelCallback:(LSDialogCallback) cancelCallback;
@end
