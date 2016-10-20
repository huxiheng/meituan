//
//  LSGroupedTableViewController.h
//  Yingfeng
//
//  Created by Lessu on 13-7-23.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString const *LSGroupedSectionHeaderKey;
extern NSString const *LSGroupedSectionChildKey;
extern NSString const *LSGroupedSectionFooterKey;

extern NSString const *LSGroupedCellTitleKey;
extern NSString const *LSGroupedCellDetailKey;
extern NSString const *LSGroupedCellImageKey;
extern NSString const *LSGroupedCellSelectorKey;
extern NSString const *LSGroupedCellOnSelectKey;
@interface LSGroupedTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_mapping;

}
@property(nonatomic,retain) NSArray *mapping;
@property(nonatomic,retain) IBOutlet UITableView *groupTableView;

@end
