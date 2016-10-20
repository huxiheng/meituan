//
//  LSVerySimpleGrideViewController.h
//  Yingcheng
//
//  Created by lessu on 14-1-3.
//  Copyright (c) 2014年 Lessu. All rights reserved.
//
//  v1.1 debug mode enabled
#import <UIKit/UIKit.h>
#import "LSPageController.h"
#import "LSRefreashAndLoadMoreGrideViewController.h"
@interface LSPagedGrideViewController : LSRefreashAndLoadMoreGrideViewController<NRGridViewDataSource,NRGridViewDelegate>

@property(nonatomic,strong) LSPageController  *pageController;
@property(nonatomic,readonly) NSString* cellNibName;

@property(nonatomic,assign)     BOOL enableDebugMode;
@property(nonatomic,assign)     NSInteger debugItemCount;
@property(nonatomic,assign)     NSDictionary *debugItemData;

//to Implement
- (void)toInitPageControllerWith:(NSString **) apiName params:(NSDictionary **)params;
- (void)afterInitPageController:(LSPageController *)pageController;
- (void)simpleGridView:(NRGridView *)gridView fillCell:(id)cell withData:(NSDictionary *)item andIndexPath:(NSIndexPath *)indexPath;
- (NSString *)  simpleGridViewViewCellNibName:(NRGridView *)gridView;
- (CGFloat)     simpleGridView:(NRGridView *)gridView cellHeightForData:(NSDictionary *)item    andIndexPath:(NSIndexPath *)indexPath;
- (void)        simpleGridView:(NRGridView *)gridView didSelectedWithData:(NSDictionary *)item  andIndexPath:(NSIndexPath *)indexPath;



- (NSDictionary *)itemForIndexPath:(NSIndexPath *)indexPath;


@end
