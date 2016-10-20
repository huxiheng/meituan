//
//  YXGallery.m
//  Youxian100
//
//  Created by zxg on 13-4-11.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSGallery.h"
#import "UIImageView+WebCache.h"
#define TAG_BG 2347
#define TAG_IMAGEVIEW_BASE 98
#define SHADOW_HEIGHT 6
#define AUTO_SCROLL_DELAY 5.0f
#define LS_GALLERY_TITLE_VIEW_HEIGHT 22
NSString const *LSGalleryDefauleImageKey = @"src";
NSString const *LSGalleryDefauleTitleKey = @"title";
@implementation LSGallery
{
    id<LSGalleryDelegate> _delegate;
    int _count;
    UIPageControl * _pageControl;
    UIImageView * _bgImageView;
    UIImageView * _shadowImageView;
    UIScrollView * _scrollView;
    
    
    UIView          *_titleBackgrounView;
    UILabel         *_titleLabel;
}

- (id)  initWithFrame:(CGRect)frame andDelegate: (id<LSGalleryDelegate>) delegate
{
    if (self = [super initWithFrame:frame]) {
        self.imageKey = (NSString *) LSGalleryDefauleImageKey;
        self.titleKey = (NSString *) LSGalleryDefauleTitleKey;
        
        _delegate = delegate;
        self.frame = frame;
        //加载数据 根据加载到的数据得站位个数
//        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ls_gallery_default"]];
//        _bgImageView.frame = self.frame;
        [self addSubview: _bgImageView];
        _shadowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ls_gallery_shadow"]];
        _shadowImageView.frame = CGRectMake(0.0f, self.height - SHADOW_HEIGHT, self.width, SHADOW_HEIGHT);
        [self addSubview:_shadowImageView];
        
        // scrollView
        _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        _scrollView.delegate = self;
        [_scrollView setPagingEnabled:YES];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        //pageControl
        _pageControl = [[UIPageControl alloc] init];
        [_pageControl addTarget:self action:@selector(pageControllTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_pageControl];
        
        _titleBackgrounView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - LS_GALLERY_TITLE_VIEW_HEIGHT, frame.size.width, LS_GALLERY_TITLE_VIEW_HEIGHT)];
        _titleBackgrounView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        
        _titleLabel = [[UILabel alloc]initWithFrame:_titleBackgrounView.bounds];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor colorWithWhite:0.75 alpha:1];
        
        [_titleBackgrounView addSubview:_titleLabel];
        [self addSubview:_titleBackgrounView];
        
    }
    return self;
}

- (void)dealloc
{
    [_titleBackgrounView release];
    [_titleLabel release];
    [_pageControl release];
    _pageControl = nil;
    [_bgImageView release];
    [_shadowImageView release];
    _shadowImageView = nil;
    [_scrollView release];
    _scrollView = nil;
    [super dealloc];
}

/**
 * 适配作用， 提取或转化 所需要的数据
 */
- (NSArray *)parseData: (NSArray *)data
{
    NSMutableArray * datas = [NSMutableArray arrayWithCapacity:data.count];
    for (int i=0; i<data.count; i++) {
        NSDictionary *item;
//        if (_preprocess) {
//            item = _preprocess(data[i]);
//        }else{
            item = data[i];
//        }
        [datas addObject:item];
    }
    return datas;
}

- (void)setData: (NSArray *)datas
{
    STRONG_ASSIGN(_data, datas);
    datas = [self parseData:datas];
    //移除之前的subViews
    NSArray * subViews = _scrollView.subviews;
    for (int i=0; i<subViews.count; i++) {
        UIView * view = subViews[i];
        [view removeFromSuperview];
    }

    _count = datas.count;
    _pageControl.numberOfPages = _count;
    [_pageControl sizeToFit];

    if(_count > 0){

        //x 居中,  y 离底部20
        _pageControl.left = (self.width - _pageControl.width)/2.0;
        _pageControl.top  = self.height - _pageControl.height;
        //移除背景图片
        [_bgImageView removeFromSuperview];
        [self bringSubviewToFront:_shadowImageView];
                
        [_scrollView setContentSize:CGSizeMake(_scrollView.width * _count, _scrollView.height)];
        for (int i =0; i<_count; i++) {
            NSDictionary * data = datas[i];
            UIImageView * imageView = [[UIImageView alloc] init];
            [imageView setFrame:CGRectMake(i * _scrollView.width, 0.0f, _scrollView.width, _scrollView.height)];//s1
            [imageView setImageWithURL:[NSURL URLWithString:data[self.imageKey]]];
            imageView.tag = TAG_IMAGEVIEW_BASE + i;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)];
            [imageView addGestureRecognizer:tapGesture];
            [tapGesture release];
            [_scrollView addSubview:imageView];
            [imageView release];
            
            _titleLabel.text = data[self.titleKey];
        }
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoScroll) object:nil];
        [self performSelector:@selector(autoScroll) withObject:nil afterDelay:AUTO_SCROLL_DELAY];

    }
}

- (void)autoScroll
{
    if (!_scrollView.isDecelerating && !_scrollView.isDragging) {
        //下一个位置
        int nextPage = (_pageControl.currentPage +1) % _count;
        [_scrollView setContentOffset:CGPointMake(nextPage * _scrollView.width, 0.0f) animated:YES];
//        _titleLabel.text = self.data[nextPage][self.titleKey];

    }
    [self performSelector:@selector(autoScroll) withObject:nil afterDelay:AUTO_SCROLL_DELAY];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int pageNo = (int)(scrollView.contentOffset.x / scrollView.width + 0.5);
    
    if (pageNo < 0) pageNo = 0;
    int totalNo = (int)(scrollView.contentSize.width/scrollView.width);
    _titleLabel.text = self.data[pageNo][self.titleKey];
    if (pageNo > totalNo-1) pageNo = totalNo - 1;
    _pageControl.currentPage = pageNo;
}


- (void)imagePressed: (UITapGestureRecognizer *)gestureRecognizer
{
    UIView * view =  gestureRecognizer.view;
    int index = view.tag - TAG_IMAGEVIEW_BASE;
    if ([_delegate respondsToSelector:@selector(lsgallery:clickAtIndex:)]) {
        [_delegate lsgallery:self clickAtIndex:index];
    }
}

- (void)pageControllTapped: (UIPageControl *) pageControl
{
    int page = pageControl.currentPage;
    [_scrollView setContentOffset:CGPointMake(page * _scrollView.width, 0.0f) animated:YES];
}



@end






