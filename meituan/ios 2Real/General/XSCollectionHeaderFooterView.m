//
//  XSCollectionHeaderFooterView.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/19.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSCollectionHeaderFooterView.h"

@implementation XSCollectionHeaderFooterView
-(void)awakeFromNib{
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}
+ (NSString *)viewIdentifier {
    return [self HYClassName];
}
-(void)initSubviews{
    
}
- (void)reloadDataForView:(id)model {
    
}
@end
