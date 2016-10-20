//
//  LSSimpleTableViewController.m
//  LSLab
//
//  Created by Lessu on 13-5-9.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSSimpleTableViewController.h"
#define demoCellDef(__title,__selectorName) @{@"title":__title}
@interface LSSimpleTableViewController ()

@end

@implementation LSSimpleTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)dealloc
{
    [_list release];
    [_textName release];
    [_detailName release];
    Block_release(_onSelected);
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
//    if ([tableView respondsToSelector:@selector(dequeueReusableCellWithIdentifier:forIndexPath:)]) {
//        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    }
    
    if (cell == NULL) {
        cell = [[[UITableViewCell alloc]initWithStyle:_cellStyle reuseIdentifier:CellIdentifier] autorelease];
    }
    NSDictionary *data = _list[indexPath.row];
    
    NSString *text = _textName?data[_textName]:nil;
    NSString *detail=_detailName?data[_detailName]:nil;
    
    cell.textLabel .text = text;
    
    cell.detailTextLabel.text =detail;
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_onSelected) {
        _onSelected(_list[indexPath.row],[tableView cellForRowAtIndexPath:indexPath]);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
