//
//  LSLayoutView.m
//  Ivoryer
//
//  Created by Lessu on 13-6-3.
//  Copyright (c) 2013年 duohuo. All rights reserved.
//

#import "LSLayoutView.h"
#import <objc/runtime.h>
@implementation LSLayoutView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSArray *subviews = [self subviews];
    float x=0,y=0;
    for (UIView *view in subviews) {
        if (view.isHidden) {
            continue;
        }
        x += [view.marginLeft floatValue];
        y += [view.marginTop floatValue];
        
        view.left= x;
        view.top = y;
        
        x += view.width;
        y += view.height;
        
        x += [view.marginRight floatValue];
        y += [view.marginBottom floatValue];
        
        if (_direct == LSLayoutVertical) {
            x = 0;
        }else if(_direct == LSLayoutHorizontak){
            y = 0;
        }else{
            x = 0;
            y = 0;
        }
    }
    if (_direct == LSLayoutVertical) {
        _contentSize = CGSizeMake(self.width, y);
    }else if(_direct == LSLayoutHorizontak){
        _contentSize = CGSizeMake(x, self.height);
    }else{
        _contentSize = self.frame.size;
    }
}

- (void)setDirectString:(NSString *)directString{
    if ([directString isEqualToString:@"Vertical"]) {
        _direct = LSLayoutVertical;
    }else if([directString isEqualToString:@"Horizontal"]){
        _direct = LSLayoutHorizontak;

    }
}
@end

#define ADD_NUMERIC_PROPERTY(PROPERTY_TYPE,PROPERTY_NAME,SETTER_NAME)\
const char kProperty##PROPERTY_NAME;\
@dynamic PROPERTY_NAME;\
- ( float ) PROPERTY_NAME {\
    NSNumber* PROPERTY_NAME = objc_getAssociatedObject(self, &( kProperty##PROPERTY_NAME ) );\
    return [PROPERTY_NAME PROPERTY_TYPE##Value];\
}\
- (void) SETTER_NAME :( PROPERTY_TYPE ) PROPERTY_NAME {\
    NSNumber *number = @(PROPERTY_NAME);\
    objc_setAssociatedObject(self, &kProperty##PROPERTY_NAME , number , OBJC_ASSOCIATION_RETAIN);\
}

@implementation UIView (LSLayoutProperty)

ADD_DYNAMIC_PROPERTY(NSNumber *, marginTop   , setMarginTop);
ADD_DYNAMIC_PROPERTY(NSNumber *, marginBottom, setMarginBottom);
ADD_DYNAMIC_PROPERTY(NSNumber *, marginLeft  , setMarginLeft);
ADD_DYNAMIC_PROPERTY(NSNumber *, marginRight , setMarginRight);

@end
