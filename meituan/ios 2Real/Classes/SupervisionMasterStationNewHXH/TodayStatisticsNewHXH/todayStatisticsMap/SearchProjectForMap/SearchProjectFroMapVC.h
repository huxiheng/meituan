//
//  SearchProjectFroMapVC.h
//  XieshiPrivate
//
//  Created by Tesiro on 16/10/17.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSViewSecondController.h"

@protocol GetSearchProjectNameDelegate;
@interface SearchProjectFroMapVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,assign)id<GetSearchProjectNameDelegate> delegate;
@end

@protocol GetSearchProjectNameDelegate <NSObject>

@optional
-(void)searchProjectFroMapVC:(SearchProjectFroMapVC *)searchProjectForVC textSearch:(NSString*)text;

@end
