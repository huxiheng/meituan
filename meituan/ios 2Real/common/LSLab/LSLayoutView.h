//
//  LSLayoutView.h
//  Ivoryer
//
//  Created by Lessu on 13-6-3.
//  Copyright (c) 2013年 duohuo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    LSLayoutVertical = 0,
    LSLayoutHorizontak,
    LSLayoutNone
} LSLayoutViewDirect;

@interface LSLayoutView : UIView
@property(nonatomic,assign) LSLayoutViewDirect  direct;
@property(nonatomic,retain) NSString            *directString;
@property(nonatomic,assign) CGSize               contentSize;
@end

@interface UIView (LSLayoutProperty)

@property(nonatomic,assign) NSNumber* marginTop;
@property(nonatomic,assign) NSNumber* marginBottom;
@property(nonatomic,assign) NSNumber* marginLeft;
@property(nonatomic,assign) NSNumber* marginRight;

@end