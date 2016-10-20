//
//  LSDialog.m
//  xiaowei
//
//  Created by Lessu on 12-11-28.
//
//

#import "LSDialog.h"
static LSDialog *lsdialog;
@implementation LSDialog
@synthesize confirmCallback = _confirmCallback;
@synthesize cancelCallback  = _cancelCallback;
+ (void)showMessage:(NSString *) message{
    return [self showAlertWithTitle:@"提示" message:message callBack:nil];
}
+ (void)showAlertWithTitle:(NSString*)title message:(NSString *)message callBack:(LSDialogCallback)callback{
    lsdialog = [[LSDialog alloc ]initAlertWithTitle:(NSString*)title message:(NSString *)message callBack:(LSDialogCallback)callback];
    [lsdialog show];
    lsdialog = nil; 
}
+ (void)showDialogWithTitle:(NSString*)title message:(NSString *)message
                confirmText:(NSString*) confirmText confirmCallback:(LSDialogCallback) confirmCallback
                 cancelText:(NSString *) cancelText cancelCallback:(LSDialogCallback) cancelCallback{
    lsdialog = [[LSDialog alloc]initDialogWithTitle:(NSString*)title message:(NSString *)message
                                        confirmText:(NSString*) confirmText confirmCallback:(LSDialogCallback) confirmCallback
                                         cancelText:(NSString *) cancelText cancelCallback:(LSDialogCallback) cancelCallback];
    [lsdialog show];
    lsdialog = nil;
}

- (id)initAlertWithTitle:(NSString*)title message:(NSString *)message callBack:(LSDialogCallback)callback{
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
    _dialogType = LSDialogAlert;
    self.cancelCallback = callback;
    return self;
    
}
- (id)initDialogWithTitle:(NSString*)title message:(NSString *)message
            confirmText:(NSString*) confirmText confirmCallback:(LSDialogCallback) confirmCallback
            cancelText:(NSString *) cancelText cancelCallback:(LSDialogCallback) cancelCallback{
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelText otherButtonTitles:confirmText,nil];
    _dialogType = LSDialogDialog;
    self.cancelCallback = cancelCallback;
    self.confirmCallback= confirmCallback;
    return self;
}


// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (_dialogType) {
        case LSDialogAlert:
            if(self.cancelCallback!=nil){
                self.cancelCallback();
            }
            break;
        case LSDialogDialog:
            
            if(self.confirmCallback!=nil&&buttonIndex==1){
                self.confirmCallback();
            }else if(self.cancelCallback!=nil&&buttonIndex==0){
                
                self.cancelCallback();
            }
            break;
        default:
            break;
    }
}
// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)alertViewCancel:(UIAlertView *)alertView{

    if(self.cancelCallback!=nil){
        self.cancelCallback();
    }
}

//- (void) dealloc{
//    //[_cancelCallback b]
//    Block_release(_cancelCallback);
//    Block_release(_confirmCallback);
//    [super dealloc];
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
