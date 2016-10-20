//
//  PopoverViewController.m
//  DItuProjectText
//
//  Created by Tesiro on 16/10/11.
//  Copyright © 2016年 Tesiro. All rights reserved.
//

#import "PopoverViewController.h"
#import "PopoveViewControllerCell.h"
#import "PopoverAnimator.h"
#import "XSPresentationController.h"
@interface PopoverViewController ()
@property (nonatomic, strong)NSArray *arrayData;
@end

@implementation PopoverViewController
-(void)viewDidLayoutSubviews{
//    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, kscaleIphone6DeviceHeight(116));
}
-(void)awakeFromNib{
    [super awakeFromNib];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayData = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    [self.table registerClass:[PopoveViewControllerCell class] forCellReuseIdentifier:[PopoveViewControllerCell cellIdentifier]];
    
    self.table.showsVerticalScrollIndicator=NO;
    self.table.rowHeight = kscaleIphone6DeviceLength(29);
}
//-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return kscaleIphone6DeviceLength(29);
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayData.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PopoveViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:[PopoveViewControllerCell cellIdentifier]];
    id model = [self.arrayData objectAtIndex:indexPath.row];
    [cell reloadDataForCell:model];
   
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *text = [self.arrayData objectAtIndex:indexPath.row];
    self.blockClickIndexPath(text);
    [((PopoverAnimator*)self.transitioningDelegate).xsPresentationController.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
