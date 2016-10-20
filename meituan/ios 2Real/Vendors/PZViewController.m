#import "PZViewController.h"

//#import "PZPagingScrollView.h"
//#import "PZPhotoView.h"
//#import "HYAssetPickerController.h"

//@interface PZViewController () <PZPagingScrollViewDelegate, PZPhotoViewDelegate, UIScrollViewDelegate>
//
//@property (strong, nonatomic) NSMutableArray *images;
//
//@property (strong, nonatomic) IBOutlet PZPagingScrollView *pagingScrollView;
//@property(strong,nonatomic) UIView *bottomView;

//@end

@implementation PZViewController


#pragma mark - View Lifecycle
#pragma mark -
//-(void)viewDidLoad
//{
//    self.title = [NSString stringWithFormat:@"%d/%d",1,self.arrayOK.count];
//    self.rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.rightbtn.frame=CGRectMake(0, 0, 22, 22);
//    [self.rightbtn setImage:[UIImage imageNamed:@"OK"] forState:UIControlStateNormal];
//    [self.rightbtn addTarget:self action:@selector(OK:)forControlEvents:UIControlEventTouchUpInside];
//    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightbtn];
//    self.arrayTotal = [NSMutableArray arrayWithArray:self.arrayOK];
//    self.arrayImageViews = [@[] mutableCopy];
//
//}
//-(void)layOut{
//    self.btnOK = [[UIButton alloc] init];
//    
//    self.btnOK.layer.cornerRadius = 5.0f;
//    self.btnOK.backgroundColor = [UIColor colorWithHexString:knavBJColor];
//    [self.btnOK setTitle:[NSString stringWithFormat:@"完成(%d)",self.arrayOK.count] forState:UIControlStateNormal];
//    self.btnOK .titleLabel.font = [UIFont systemFontOfSize:15];
//    [self.btnOK addTarget:self action:@selector(complete:) forControlEvents:UIControlEventTouchUpInside];
//    self.btnOK.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 44, [UIScreen mainScreen].bounds.size.width, 44)];
//    self.bottomView.backgroundColor = [UIColor lightGrayColor];
//    [self.bottomView addSubview:self.btnOK];
//    self.bottomView.alpha = 0.95f;
//    
//    [self.view addSubview:self.bottomView];
//    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.btnOK
//                                                                  attribute:NSLayoutAttributeTrailing
//                                                                  relatedBy:NSLayoutRelationEqual
//                                                                     toItem:self.bottomView
//                                                                  attribute:NSLayoutAttributeTrailing
//                                                                 multiplier:1.0f
//                                                                   constant:-10.0f];
//    [self.bottomView addConstraint:constraint];
//    
//    constraint = [NSLayoutConstraint constraintWithItem:self.btnOK
//                                              attribute:NSLayoutAttributeCenterY
//                                              relatedBy:NSLayoutRelationEqual
//                                                 toItem:self.bottomView
//                                              attribute:NSLayoutAttributeCenterY
//                                             multiplier:1.0f
//                                               constant:0.0f];
//    [self.bottomView addConstraint:constraint];
//    
//    constraint = [NSLayoutConstraint constraintWithItem:self.btnOK
//                                              attribute:NSLayoutAttributeWidth
//                                              relatedBy:NSLayoutRelationEqual
//                                                 toItem:nil
//                                              attribute:NSLayoutAttributeNotAnAttribute
//                                             multiplier:0.0f
//                                               constant:64.0f];
//    [_btnOK addConstraint:constraint];
//
//}
//-(void)complete:(UIButton *)sender{
//    HYAssetPickerController *pickController = (HYAssetPickerController *)self.navigationController;
//    [pickController.delegate getAssetFromPickerController:self.arrayOK];
//    [self dismissViewControllerAnimated:YES completion:Nil];
//}
//-(void)OK:(UIButton *)sender{
//    
//    if ([self.arrayOK containsObject:self.arrayTotal[self.currentIndex]]) {
//        [self.rightbtn setImage:[UIImage imageNamed:@"No"] forState:UIControlStateNormal];
//        [self.arrayOK removeObject:self.arrayTotal[self.currentIndex]];
//    }
//    else{
//        [self.rightbtn setImage:[UIImage imageNamed:@"OK"] forState:UIControlStateNormal];
//        [self.arrayOK addObject:self.arrayTotal[self.currentIndex]];
//    }
//    if (!self.arrayOK.count) {
//        self.btnOK.enabled = NO;
//        self.btnOK.backgroundColor = [UIColor colorWithHexString:@"#eaebed"];
//        [self.btnOK setTitle:@"完成" forState:UIControlStateNormal];
//        [self.btnOK setTitleColor:[UIColor colorWithHexString:@"#cfd0d2"] forState:UIControlStateNormal];
//        return;
//    }
//    self.btnOK.enabled = YES;
//    [self.btnOK setBackgroundColor:[UIColor colorWithHexString:knavBJColor]];
//    [self.btnOK setTitle:[NSString stringWithFormat:@"完成(%d)",self.arrayOK.count] forState:UIControlStateNormal];
//}
//-(void)dismiss{
//    
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.alpha = 0.95;
//    self.pagingScrollView = [[PZPagingScrollView alloc] init];
//    self.pagingScrollView.pagingViewDelegate = self;
//    self.pagingScrollView.frame = self.view.frame;
//    [self.view addSubview:self.pagingScrollView];
//    
//    self.images = [@[] mutableCopy];
//    for (ALAsset *alaset in self.arrayOK) {
//        [self.images addObject:[UIImage imageWithCGImage:alaset.defaultRepresentation.fullScreenImage]];
//    }
//    [self.pagingScrollView displayPagingViewAtIndex:0];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        self.pagingScrollView.contentInset = UIEdgeInsetsZero;
//    });
//
//    self.pagingScrollView.arrayOK = self.arrayOK;
//    self.pagingScrollView.arrayTotal = self.arrayTotal;
//}
////不调用[self viewWillAppear:YES]，出现问题，当点击显示全屏的时候，图片会往上面走
//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:YES];
//    [self viewWillAppear:YES];
//    [self layOut];
//
//}
//-(void)viewWillDisappear:(BOOL)animated
//{
//    self.navigationController.navigationBar.alpha = 1.0f;
//
//}
//#pragma mark - User Actions
//#pragma mark -
//
//- (void)toggleFullScreen {
//    if (self.navigationController.navigationBar.alpha == 0.0) {
//        // fade in navigation
//        
//        [UIView animateWithDuration:0.4 animations:^{
//            [[UIApplication sharedApplication] setStatusBarHidden:FALSE withAnimation:UIStatusBarAnimationNone];
//            self.navigationController.navigationBar.alpha = 0.95;
//            self.bottomView.frameOriginY = [UIScreen mainScreen].bounds.size.height - 44;
//        } completion:^(BOOL finished) {
//        }];
//    }
//    else {
//        // fade out navigation
//        
//        [UIView animateWithDuration:0.4 animations:^{
//            [[UIApplication sharedApplication] setStatusBarHidden:TRUE withAnimation:UIStatusBarAnimationFade];
//            self.navigationController.navigationBar.alpha = 0.0;
//            self.bottomView.frameOriginY = [UIScreen mainScreen].bounds.size.height;
//        } completion:^(BOOL finished) {
//        }];
//    }
//}
//
//#pragma mark - PZPagingScrollViewDelegate
//#pragma mark -
//
//- (Class)pagingScrollView:(PZPagingScrollView *)pagingScrollView classForIndex:(NSUInteger)index {
//    // all page views are photo views
//    return [PZPhotoView class];
//}
//
//- (NSUInteger)pagingScrollViewPagingViewCount:(PZPagingScrollView *)pagingScrollView {
//    return self.images.count;
//}
//
//- (UIView *)pagingScrollView:(PZPagingScrollView *)pagingScrollView pageViewForIndex:(NSUInteger)index {
//    PZPhotoView *photoView = [[PZPhotoView alloc] initWithFrame:self.view.bounds];
//    photoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    photoView.photoViewDelegate = self;
//    
//    return photoView;
//}
//
//- (void)pagingScrollView:(PZPagingScrollView *)pagingScrollView preparePageViewForDisplay:(UIView *)pageView forIndex:(NSUInteger)index {
//    assert([pageView isKindOfClass:[PZPhotoView class]]);
//    assert(index < self.images.count);
//    
//    PZPhotoView *photoView = (PZPhotoView *)pageView;
//    UIImage *image = [self.images objectAtIndex:index];
//    [photoView displayImage:image];
//}
//
//#pragma mark - PZPhotoViewDelegate
//#pragma mark -
//
//- (void)photoViewDidSingleTap:(PZPhotoView *)photoView {
//    [self toggleFullScreen];
//}
//
//- (void)photoViewDidDoubleTap:(PZPhotoView *)photoView {
//    // do nothing
//}
//
//- (void)photoViewDidTwoFingerTap:(PZPhotoView *)photoView {
//    // do nothing
//}
//
//- (void)photoViewDidDoubleTwoFingerTap:(PZPhotoView *)photoView {
////    [self logLayout];
//}
//-(void)pzscrollViewDidScroll:(UIScrollView *)scrollView
//{
//    int index = lroundf(scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width);
//    if (index != self.currentIndex) {
//        if ([self.arrayOK containsObject:self.arrayTotal[index]]) {
//            [self.rightbtn setImage:[UIImage imageNamed:@"OK"] forState:UIControlStateNormal];
//        }
//        else{
//            [self.rightbtn setImage:[UIImage imageNamed:@"No"] forState:UIControlStateNormal];
//        }
//        self.title = [NSString stringWithFormat:@"%d/%d",index + 1,self.arrayTotal.count];
//        self.currentIndex = index;
//    }
//}
//- (void)pzscrollViewDidEndDecelerating:(UIScrollView *)scrollView      // called when scroll view grinds to a halt
//{
//    NSInteger currentIndex = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
//    self.currentIndex = currentIndex;
//}
//
@end
