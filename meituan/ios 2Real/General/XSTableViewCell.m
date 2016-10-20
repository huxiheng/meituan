//
//  XSTableViewCell.m
//  Xieshi
//
//  Created by Tesiro on 16/7/13.
//  Copyright © 2016年 Lessu. All rights reserved.
//

#import "XSTableViewCell.h"

@implementation XSTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
+ (NSString *)cellIdentifier {
    return [self HYClassName];
}
+ (CGFloat)returnCellHeight:(id)model {
    return 0.0f;
}
- (void)addLineView:(CGRect)frame {
    self.viewLine =[[UIView alloc] initWithFrame:frame];
    self.viewLine.backgroundColor =kcolorLine;
    [self.contentView addSubview:self.viewLine];
}
//override
- (void)initSubviews {
    
}
- (void)reloadDataForCell:(id)model {
    
}

@end
