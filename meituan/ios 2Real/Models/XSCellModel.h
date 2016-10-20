//
//  XSCellModel.h
//  Xieshi
//
//  Created by Tesiro on 16/7/13.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSCellModel : NSObject
@property (nonatomic, strong)NSString    *title;
@property (nonatomic, strong)NSString    *content;
@property (nonatomic, assign)BOOL      tagColor;
@property (nonatomic, assign)float     heightcontent;
@property (nonatomic, strong)UIImage   *images;
@end
