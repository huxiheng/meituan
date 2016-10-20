//
//  XSMainViewController.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/7/20.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSMainViewController.h"
#import "XSLeftViewController.h"


@implementation XSMainViewController

- (void)setData {
    self.titleForNav = @"工地列表";
}

- (void)leftItemClick:(id)sender {
    [self.viewDeckController toggleLeftView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.loadOnlyOnce = true;
    self.pageController.pageName = @"CurrentPageNo";
    self.pageController.stepName = @"PageSize";
    
    [self setNavLeftItemWith:@"" andImage:[UIImage imageNamed:@"navcaidan"]];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)];
//    
//    if ([self.navigationItem respondsToSelector:@selector(leftBarButtonItems)]) {
//        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:
//                                                  [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)],
//                                                  [[UIBarButtonItem alloc] initWithTitle:@"bounce" style:UIBarButtonItemStyleBordered target:self action:@selector(previewBounceLeftView)],
//                                                  nil];
//    } else {
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)];
//    }
//    
//    if ([self.navigationItem respondsToSelector:@selector(rightBarButtonItems)]) {
//        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:
//                                                   [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleRightView)],
//                                                   [[UIBarButtonItem alloc] initWithTitle:@"bounce" style:UIBarButtonItemStyleBordered target:self action:@selector(previewBounceRightView)],
//                                                   [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(showCam:)],
//                                                   nil];
//    }
//    else {
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleRightView)];
//    }
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64) style:UITableViewStylePlain];
//    self.table.delegate = self;
//    self.table.dataSource = self;
    [self.view addSubview:self.table];
   
    [self addRefreshHeaderAndFooter:self.table];
    
//    ((XSLeftViewController *)self.viewDeckController.leftController).powerString= @"123";
}

//to Implement
- (void)toInitPageControllerWith:(NSString **) apiName params:(NSDictionary **)params{
    *apiName = APIMETHOD_SM_ProjectList;
    *params  =  @{
                  @"Token"              : [LoginUtil token],
                  @"NotFinishedOnly"    : [NSNumber numberWithBool:true],
                  @"QueryStr"           : @""
                  };
}
- (void)afterInitPageController:(LSPageController *)pageController{
    pageController.apiClass = @"CommonAPI";
    [pageController setPageinfoAdapter:^(NSDictionary *input, BOOL *success, NSArray *__autoreleasing * list, int *totalCount, NSString *__autoreleasing *errorMessage) {
        *success = [input[kAPIConnectionStandartSuccessKey] boolValue];
        if (success) {
            
            *list = input[kAPIConnectionStandartDataKey][@"ListContent"];
            
            self.dataListArray =input[kAPIConnectionStandartDataKey][@"ListContent"];
            [self getCellArrayData];
            
            *totalCount = [input[kAPIConnectionStandartDataKey][@"PageCount"] integerValue];
        }else{
            *errorMessage = input[kAPIConnectionStandartMessageKey];
            
        }
    }];
}

- (void)getCellArrayData{
    NSArray *arrayTitle = @[@"工地名称",@"工地状态",@"工地性质",@"所属区县",@""];
    NSArray *arrayImage = @[];
    
    for ( int i = 0; i<self.dataListArray.count; i++) {
        NSDictionary *dicCell = [self.dataListArray objectAtIndex:i];
        NSMutableArray *arrayContent = [[NSMutableArray alloc] initWithObjects:dicCell[@"ProjectName"],dicCell[@"ProjectStatus"],dicCell[@"ProjectNature"],dicCell[@"ProjectRegion"],dicCell[@"ProjectAddress"], nil];
        
        
        
        
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)previewBounceLeftView {
    [self.viewDeckController previewBounceView:IIViewDeckLeftSide];
}

- (void)previewBounceRightView {
    [self.viewDeckController previewBounceView:IIViewDeckRightSide];
}

- (void)previewBounceTopView {
    [self.viewDeckController previewBounceView:IIViewDeckTopSide];
}

- (void)previewBounceBottomView {
    [self.viewDeckController previewBounceView:IIViewDeckBottomSide];
}

- (void)showCam:(id)sender {
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        picker.sourceType =  UIImagePickerControllerSourceTypeCamera;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self.popoverController dismissPopoverAnimated:NO];
        self.popoverController = [[UIPopoverController alloc] initWithContentViewController:picker];
        [self.popoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    else {
        [self presentModalViewController:picker animated:YES];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataListArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dic;
    return dic.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath.section) {
        self.viewDeckController.leftSize = MAX(indexPath.row*44,10);
    }
    else {
        self.viewDeckController.rightSize = MAX(indexPath.row*44,10);
    }
}
@end
