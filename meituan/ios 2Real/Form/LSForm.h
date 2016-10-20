//
//  LSForm.h
//  YinfengShop
//
//  Created by lessu on 13-12-23.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LSFTextInputViewController.h"


#import "LSFormCell.h"

#import "LSFormTextCell.h"
#import "LSFormTextLabelCell.h"
#import "LSFormTextFieldCell.h"
#import "LSFormTextViewCell.h"
#import "LSFormSwitchCell.h"
#import "LSFormTimeRangeCell.h"
#import "LSFormSelectCell.h"
#import "LSFormImageCollectionCell.h"
@interface LSForm : NSObject

@end



//MapperFormKey
extern NSString* LSFormTableMapperFormHeaderKey;
extern NSString* LSFormTableMapperFormCellKey;
extern NSString* LSFormTableMapperFormFooterKey;

extern NSString* LSFormTableMapperCellClassKey;
extern NSString* LSFormTableMapperCellNameKey;
extern NSString* LSFormTableMapperCellKeyNameKey;

extern NSString* LSFormTableMapperCellLabelKey;
//maybe not neccesary
extern NSString* LSFormTableMapperCellValueKey;

extern NSString* LSFormTableMapperCellRuleKey;
extern NSString* LSFormTableMapperCellHeightNewKey;