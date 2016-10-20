#import "ShowBigViewController.h"
#define IOS7LATER  [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
@interface ShowBigViewController ()

@end

@implementation ShowBigViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置导航栏的rightButton
    self.title = [NSString stringWithFormat:@"%d/%li",1,self.arrayOK.count];
    self.rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightbtn.frame=CGRectMake(0, 0, 22, 22);
    [self.rightbtn setImage:[UIImage imageNamed:@"OK"] forState:UIControlStateNormal];
    [self.rightbtn addTarget:self action:@selector(OK:)forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightbtn];
     //设置导航栏的leftButton
//    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftbtn.frame=CGRectMake(0, 0, 11, 20);
//    [leftbtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
//    [leftbtn addTarget:self action:@selector(dismiss)forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.arrayTotal = [NSMutableArray arrayWithArray:self.arrayOK];
    self.arrayImageViews = [@[] mutableCopy];
    [self layOut];
    
}

-(void)layOut{
    self.view.backgroundColor = [UIColor blackColor];
            //arrayOK里存放选中的图片
   
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if (IOS7LATER)
    {
          self.scrollerview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50)];
    }
#endif
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
    }
    else
    {
        _scrollerview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height- 100)];
    }
    
    
    //显示选中的图片的大图
  
    self.scrollerview.maximumZoomScale = 2.0f;
    self.scrollerview.minimumZoomScale = 0.2f;
    self.scrollerview.backgroundColor = [UIColor blackColor];
    self.scrollerview.showsHorizontalScrollIndicator = NO;
    self.scrollerview.showsVerticalScrollIndicator = NO;
    self.scrollerview.pagingEnabled = YES;
    self.scrollerview.delegate = self;
    
    for (int i=0; i<[self.arrayOK count]; i++) {
       ALAsset *asset=self.arrayOK[i];
        
        UIImageView *imgview=[[UIImageView alloc] initWithFrame:CGRectMake(i*_scrollerview.frame.size.width, 0, _scrollerview.frame.size.width, _scrollerview.frame.size.height)];
        imgview.contentMode=UIViewContentModeScaleAspectFit;
        imgview.clipsToBounds=YES;
        UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        [imgview setImage:tempImg];
        [self.scrollerview addSubview:imgview];
        [self.arrayImageViews addObject:imgview];
    }
    
    self.scrollerview.contentSize = CGSizeMake((self.arrayOK.count) * (self.view.frame.size.width),0);
    [self.view addSubview:_scrollerview];
    
    
    self.btnOK = [[UIButton alloc] init];

    self.btnOK.layer.cornerRadius = 5.0f;
    self.btnOK.backgroundColor = [UIColor colorWithHexString:@"#18bdf3"];
    [self.btnOK setTitle:[NSString stringWithFormat:@"完成(%d)",self.arrayOK.count] forState:UIControlStateNormal];
    self.btnOK .titleLabel.font = [UIFont systemFontOfSize:15];
    [self.btnOK addTarget:self action:@selector(complete:) forControlEvents:UIControlEventTouchUpInside];
    self.btnOK.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 44, [UIScreen mainScreen].bounds.size.width, 44)];
    bottomView.backgroundColor = [UIColor lightGrayColor];
    [bottomView addSubview:self.btnOK];

    [self.view addSubview:bottomView];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.btnOK
                                                                  attribute:NSLayoutAttributeTrailing
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:bottomView
                                                                  attribute:NSLayoutAttributeTrailing
                                                                 multiplier:1.0f
                                                                   constant:-10.0f];
    [bottomView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:self.btnOK
                                              attribute:NSLayoutAttributeCenterY
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:bottomView
                                              attribute:NSLayoutAttributeCenterY
                                             multiplier:1.0f
                                               constant:0.0f];
    [bottomView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:self.btnOK
                                              attribute:NSLayoutAttributeWidth
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:nil
                                              attribute:NSLayoutAttributeNotAnAttribute
                                             multiplier:0.0f
                                               constant:64.0f];
    [_btnOK addConstraint:constraint];

    
}
-(void)complete:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:Nil];
}

-(void)OK:(UIButton *)sender{
    
    if ([self.arrayOK containsObject:self.arrayTotal[self.currentIndex]]) {
        [self.rightbtn setImage:[UIImage imageNamed:@"No"] forState:UIControlStateNormal];
        [self.arrayOK removeObject:self.arrayTotal[self.currentIndex]];
    }
    else{
        [self.rightbtn setImage:[UIImage imageNamed:@"OK"] forState:UIControlStateNormal];
        [self.arrayOK addObject:self.arrayTotal[self.currentIndex]];
    }
    if (!self.arrayOK.count) {
        self.btnOK.enabled = NO;
        self.btnOK.backgroundColor = [UIColor colorWithHexString:@"#eaebed"];
        [self.btnOK setTitle:@"完成" forState:UIControlStateNormal];
        [self.btnOK setTitleColor:[UIColor colorWithHexString:@"#cfd0d2"] forState:UIControlStateNormal];
        return;
    }
    [self.btnOK setBackgroundColor:[UIColor colorWithHexString:@"#18bdf3"]];
    [self.btnOK setTitle:[NSString stringWithFormat:@"完成(%d)",self.arrayOK.count] forState:UIControlStateNormal];
}

-(void)dismiss{

    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidZoom:(UIScrollView *)scrollView// any zoom scale changes
{
    NSLog(@"----%@",NSStringFromSelector(_cmd));
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView     // return a view that will be scaled. if delegate returns nil, nothing happens
{
    NSLog(@"----%@",NSStringFromSelector(_cmd));
    return self.arrayImageViews[self.currentIndex];
}
-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    NSLog(@"----%@",NSStringFromSelector(_cmd));
}
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    NSLog(@"----%@",NSStringFromSelector(_cmd));
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int index = lroundf(scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width);
    if (index != self.currentIndex) {
        if ([self.arrayOK containsObject:self.arrayTotal[index]]) {
            [self.rightbtn setImage:[UIImage imageNamed:@"OK"] forState:UIControlStateNormal];
        }
        else{
            [self.rightbtn setImage:[UIImage imageNamed:@"No"] forState:UIControlStateNormal];
        }
        self.title = [NSString stringWithFormat:@"%d/%d",index + 1,self.arrayTotal.count];
        self.currentIndex = index;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView      // called when scroll view grinds to a halt
{
    NSInteger currentIndex = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    self.currentIndex = currentIndex;
}
@end
