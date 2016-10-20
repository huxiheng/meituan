//
//  XSCollectionViewCell.m
//  XieshiPrivate
//
//  Created by Tesiro on 16/9/19.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSCollectionViewCell.h"

@implementation XSCollectionViewCell
-(void)awakeFromNib{
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}
+ (NSString *)cellIdentifier {
    return [self HYClassName];
}
-(void)initSubviews{
    
}
- (void)reloadDataForCell:(id)model {
    
}
@end
