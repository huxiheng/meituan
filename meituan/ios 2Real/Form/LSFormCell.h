//
//  LSFormCell.h
//  YinfengShop
//
//  Created by lessu on 13-12-23.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//
/**
 when init called,and read the mapper,the following method will be called to init this cell
 - (void)onInitWithLabel:(NSString *)label value:(id)value andRule:(NSDictionary *)rule;

 cell height should be given once inited.so data maybe nil at this time.
 if it is a static cell,a const is enough;
 if it is a dymanic heighted cell,a default height should be given when no data is given
  - (CGFloat)cellHeight;
 
 when a data is given,will call this method
 - (void)setData:(NSString *)data;

 when this cell is selected will call this method,and if all the logic is done,don't forget to call onComplete
 - (void)onSelected:(LSFormTableViewController *)viewController complete:(void(^)())onComplete;
 
 when data should be collected this method is called
 - (id)data;
 */

#import <UIKit/UIKit.h>
#define CellNameKeyed(__keyed) [NSString stringWithFormat:@"%@Cell",__keyed] 

@class LSFormTableViewController;

@protocol LSFormCellDelegate;
extern NSString *LSFormCellRuleCellStyleKey;
extern NSString *LSFormCellRuleAccessoryTypeKey;
@interface LSFormCell : UITableViewCell
{
    NSDictionary *_mapper;
    id           _data;
}
@property(nonatomic,strong)     NSDictionary *mapper;
@property(nonatomic,strong)     id data;
@property(nonatomic,copy)       void(^onComplete)();

@property(nonatomic,readonly)   NSString* cellName;
@property(nonatomic,assign)     UIViewController<LSFormCellDelegate>* delegate;
@property (nonatomic, weak) UITableView *expandableTableView;


- (instancetype)initWithMapper:(NSDictionary *)mapper;
- (CGFloat)cellHeight;
+ (NSDictionary *)mapperWithClassName:(NSString *)className cellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label value:(NSString *)value andRule:(NSDictionary*)rule;
+ (NSDictionary *)mapperWithClassName:(NSString *)className cellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label value:(NSString *)value andRule:(NSDictionary*)rule andDateType:(NSString * )type;
+ (NSDictionary *)mapperWithClassName:(NSString *)className cellName:(NSString *)cellName keyName:(NSString *)keyName label:(NSString *)label value:(NSString *)value andRule:(NSDictionary*)rule andHeight:(NSString * )height;

- (void)onInitWithLabel:(NSString *)label value:(NSString *)value andRule:(NSDictionary *)rule;
- (void)setData:(id)data;
- (void)onSelected:(LSFormTableViewController *)viewController complete:(void(^)())onComplete;
@end

@protocol LSFormCellDelegate <NSObject>
@required
- (void)cell:(LSFormCell *)cell valuedChanged:(id)value;
- (void)cell:(LSFormCell *)cell heightChanged:(CGFloat)height;

- (void)cell:(LSFormCell *)cell heightTextViewChanged:(CGFloat)height;

@end