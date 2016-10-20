//
//  LSGroupedTableViewController.m
//  Yingfeng
//
//  Created by Lessu on 13-7-23.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSGroupedTableViewController.h"
NSString const *LSGroupedSectionHeaderKey = @"header";
NSString const *LSGroupedSectionChildKey	 = @"child";
NSString const *LSGroupedSectionFooterKey = @"footer";

NSString const *LSGroupedCellTitleKey	= @"title";
NSString const *LSGroupedCellDetailKey	= @"detail";
NSString const *LSGroupedCellImageKey	= @"image";
NSString const *LSGroupedCellSelectorKey	= @"selector";
NSString const *LSGroupedCellOnSelectKey = @"onSelect";
@interface LSGroupedTableViewController ()
{
}
@end

@implementation LSGroupedTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    [_groupTableView release];
    [_mapping release];
    [super dealloc];
}

#pragma mark setter
- (void)setGroupTableView:(UITableView *)groupTableView{
    STRONG_ASSIGN(_groupTableView, groupTableView);
    _groupTableView.delegate = self;
    _groupTableView.dataSource = self;
    [_groupTableView reloadData];
}
#pragma -mark UITableViewDelegate / UITableViewDataSource
//Section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return _mapping.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return _mapping[section][LSGroupedSectionHeaderKey];
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
	return _mapping[section][LSGroupedSectionFooterKey];
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//	return 100;
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	NSDictionary *item = LS_CAST(NSArray *,  _mapping[indexPath.section][LSGroupedSectionChildKey])[indexPath.row];
	if (item[LSGroupedCellOnSelectKey]) {
		( (void (^)(UITableView *tableview)) item[LSGroupedCellOnSelectKey] )(tableView);
	}else if(item[LSGroupedCellSelectorKey]){
		[self performSelector:NSSelectorFromString(item[LSGroupedCellSelectorKey]) withObject:tableView];
	}
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return LS_CAST(NSArray *,  _mapping[section][LSGroupedSectionChildKey]) .count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *identifier = @"cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	
	NSDictionary *item = LS_CAST(NSArray *,  _mapping[indexPath.section][LSGroupedSectionChildKey])[indexPath.row];
	if (cell == nil) {
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell .textLabel.adjustsFontSizeToFitWidth = true;
        cell .textLabel.minimumFontSize = 9;
//        cell .textLabel.numberOfLines = 0;
//        cell .textLabel.lineBreakMode = NSLineBreakByCharWrapping;
		[cell autorelease];
	}
    
	cell.textLabel.text = item[LSGroupedCellTitleKey];
	cell.detailTextLabel.text = item[LSGroupedCellDetailKey];
	
	return cell;
}

@end
