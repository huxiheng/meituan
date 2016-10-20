//
//  UploadViewController.m
//  XieshiPrivate
//
//  Created by 明溢 李 on 14-12-26.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//

#import "UploadViewController.h"
#import "AppDelegate.h"
#import "UploadListTableViewCell.h"
#import "UploadImageDetailViewController.h"
#import "BlockUI.h"
@interface UploadViewController ()<UploadListTableViewCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,weak) IBOutlet UITableView *tableView;
@property(nonatomic,retain) NSArray *list;
@property(nonatomic,retain) UploadListTableViewCell *lastSelectedCell;
@end

@implementation UploadViewController
- (void)setData{
    self.titleForNav = @"图片上传";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_navigation_menu"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonDidPress:)];
    self.navigationItem.leftBarButtonItem = barButton;

    self.title= @"图片上传";

    [_tableView registerNib:[UINib nibWithNibName:@"UploadListTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self dataRequest];
}
- (void)leftBarButtonDidPress:(UIBarButtonItem *)sender{
    [APP_DELEGATE.rootMainViewController showLeft];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dataRequest{
    NSDictionary     *params  =  @{                    
#warning debug token
                                   //                  @"Token"       : [LoginUtil token],
                                   @"Token"       : @"1574824c-3edc-4910-94a9-405aceb21ef9",
                                   @"ProjectName" : @"",
                                   @"TaskName"    : @""
                                   };
    APIConnection *connection = [[CommonAPI sharedInstance]connectionWithApiName:APIMETHOD_STAKE_GetTaskList params:params];
    [connection setOnSuccess:^(id result) {
        [self updateUI:ARRAY_EMPTY_IF_NOT( result[kAPIConnectionStandartDataKey] )];
        [SVProgressHUD dismiss];
    }];
    [connection setOnFailed:^(NSError *error) {
        NSString *errorDescription = [error localizedDescription];
        [SVProgressHUD dismissWithError:STRING_FORMAT(@"%@",errorDescription) afterDelay:2.5f];
    }];
    [SVProgressHUD show];
    [connection startAsynchronous];
}
- (void)updateUI:(NSArray *)list{
    _list = list;
    if(_list.count == 0){
        [LSDialog showAlertWithTitle:@"提示" message:@"暂无数据" callBack:0];
    }
    
    [_tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _list.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UploadListTableViewCell cellHeight];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UploadListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSDictionary *item = _list[indexPath.row];
    cell.data = item;
    cell.delegate = self;
    return cell;
}

//impl method
- (void)lsRefreashableViewControllerWillRefreash{
    [self dataRequest];
    [self finishRefreash];
}

- (void)uploadListTableViewCell:(UploadListTableViewCell *)cell uploadButtonDidPress:(UIButton *)sender{
//    UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypeCamera|UIImagePickerControllerSourceTypePhotoLibrary;
//    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    }
    _lastSelectedCell = cell;
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"选择图片" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    [sheet showInView:self.view withCompletionHandler:^(NSInteger buttonIndex) {
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        if (buttonIndex == 0) {
            picker.sourceType   = UIImagePickerControllerSourceTypeCamera;
        }else if(buttonIndex ==1){
            picker.sourceType   = UIImagePickerControllerSourceTypePhotoLibrary;            
        }else {
            return ;
        }

        picker.delegate     = self;

        [self presentModalViewController:picker animated:YES];
    }];


}
- (void)uploadListTableViewCell:(UploadListTableViewCell *)cell downloadButtonDidPress:(UIButton *)sender{
    UploadImageDetailViewController *controller = [[UploadImageDetailViewController alloc]init];
    controller.taskId = cell.data[@"TaskID"];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"选择图片位置" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"图片1",@"图片2",@"图片3", nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [sheet showInView:self.view withCompletionHandler:^(NSInteger buttonIndex) {
            UIImage * image=[info objectForKey:UIImagePickerControllerOriginalImage];
            if (buttonIndex == 0) {
                [self uploadImageRequest:image index:1];
            }else if (buttonIndex == 1) {
                [self uploadImageRequest:image index:2];         
            }else if (buttonIndex == 2) {
                [self uploadImageRequest:image index:3];
            }
        }];
    });
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)uploadImageRequest:(UIImage *)image index:(NSInteger) index{

    
    NSData *dataObj = UIImageJPEGRepresentation(image, 0.6); 
    //    NSData *mydata=UIImageJPEGRepresentation(image , 0.4);
    
    NSString *string =[dataObj base64Encoding];
    //    NSString *string = [[dataObj description] stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    string = [string stringByReplacingOccurrencesOfString:@"<" withString:@""];
    //    string = [string stringByReplacingOccurrencesOfString:@">" withString:@""];
    NSDictionary *params = @{
                             @"Token"   : [LoginUtil token],
                             @"TaskID"  : _lastSelectedCell.data[@"TaskID"],
                             @"ImgByte" : string,
                             @"ImgIndex" : @(index),
                             };
    
    APIConnection *connection = [[CommonAPI sharedInstance]connectionWithApiName:APIMETHOD_STAKE_UploadTaskImage params:params];
    [connection setOnSuccess:^(id result) {
        [SVProgressHUD dismissWithSuccess:@"操作成功"];
    }];
    [connection setOnFailed:^(NSError *error) {
        NSString *errorDescription = [error localizedDescription];
        [SVProgressHUD dismissWithError:STRING_FORMAT(@"%@",errorDescription) afterDelay:2.5f];
    }];
    [SVProgressHUD show];
    [connection startAsynchronous];
}

-(void)imagePickerControllerDIdCancel:(UIImagePickerController*)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}
@end
