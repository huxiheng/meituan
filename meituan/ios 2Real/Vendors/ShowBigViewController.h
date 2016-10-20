
#import <UIKit/UIKit.h>
#import "HYAssetPickerController.h"
@interface ShowBigViewController : UIViewController<UIScrollViewDelegate,UINavigationControllerDelegate>



@property(nonatomic,strong) NSMutableArray *arrayOK;     //选中的图片数组
@property(nonatomic,strong) NSMutableArray *arrayTotal;//删掉的
@property(nonatomic)            NSInteger  currentIndex;
@property(nonatomic,strong) UIImageView     *imagvtitle;
@property(nonatomic,strong) UIScrollView    *scrollerview;
@property(nonatomic,strong) UIButton        *btnOK;
@property(nonatomic,strong) UIButton        *rightbtn;
@property(nonatomic,strong) NSMutableArray  *arrayImageViews;
@end
