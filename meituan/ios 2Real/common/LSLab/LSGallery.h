//
//  YXGallery.h
//  Youxian100
//
//  Created by lessu on 13-4-11.
//  Copyright (c) 2013年 Lessu. All rights reserved.
// v1.1 lessu 增加 title，以及 默认key

#import <UIKit/UIKit.h>
extern NSString const *LSGalleryDefauleImageKey;
extern NSString const *LSGalleryDefauleTitleKey;

@class LSGallery;

@protocol LSGalleryDelegate <NSObject>

- (void)lsgallery: (LSGallery *) gallery clickAtIndex: (int )index;

@end

@interface LSGallery : UIView<UIScrollViewDelegate>
//@property (nonatomic,copy) NSDictionary * (^preprocess)(NSDictionary *data);
@property(nonatomic,retain) NSArray* data;
@property(nonatomic,retain) NSString* imageKey;
@property(nonatomic,retain) NSString* titleKey;
- (id)  initWithFrame:(CGRect)frame andDelegate: (id<LSGalleryDelegate>) delegate;


@end


