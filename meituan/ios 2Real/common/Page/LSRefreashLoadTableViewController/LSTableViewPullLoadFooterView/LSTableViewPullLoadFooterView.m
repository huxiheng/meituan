//
//  LSTableViewPullLoadFooterView.m
//  SeeCollection
//
//  Created by Lessu on 13-3-3.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "LSTableViewPullLoadFooterView.h"

#define TEXT_COLOR	 [UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f
#define TRIGGER_DISTANCE 60
@implementation LSTableViewPullLoadFooterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//		self.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
        self.backgroundColor = [UIColor clearColor];
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 20.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont boldSystemFontOfSize:13.0f];
		label.textColor = TEXT_COLOR;
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:label];
		_statusLabel=label;
		[label release];
		
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(25.0f, 20.0f, 30.0f, 55.0f);
		layer.contentsGravity = kCAGravityResizeAspect;
		layer.contents = (id)[UIImage imageNamed:@"blueArrow.png"].CGImage;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
			layer.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
		
//		[[self layer] addSublayer:layer];
//		_arrowImage=layer;
		
		UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		view.frame = CGRectMake(25.0f, 20.0f, 20.0f, 20.0f);
		[self addSubview:view];
		_activityView = view;
		[view release];
		_hasMore = true;
		[self setState:LSPullRefreshNormal];
    }
    return self;
}
- (void)setTextColor:(UIColor *)textColor{
    if (_textColor == textColor)  return;
    [_textColor release];
    _textColor = [textColor retain];
    _statusLabel .textColor = textColor;
}
- (void)setState:(LSPullRefreshState)aState{
	
	switch (aState) {
		case LSPullRefreshPulling:
			_statusLabel.text = NSLocalizedString(@"松开完成加载...", @"Release to load more status");
			break;
		case LSPullRefreshNormal:
            if (_hasMore) {
                _statusLabel.text = NSLocalizedString(@"上拉加载更多...", @"Pull down to load more status");
            }else{
                _statusLabel.text = NSLocalizedString(@"没有更多了", @"NoMore Status");
            }
			[_activityView stopAnimating];

			break;
		case LSPullRefreshLoading:
			
			_statusLabel.text = NSLocalizedString(@"加载中...", @"Loading Status");
			[_activityView startAnimating];
            
			break;

		default:
			break;
	}
	_state = aState;
}
- (void)setHasMore:(BOOL)hasMore{
    _hasMore = hasMore;
    [self setState:_state];
}

#pragma mark -
#pragma mark ScrollView Methods
- (void)lsLoadScrollViewDidScroll:(UIScrollView *)scrollView {
	if (_state == LSPullRefreshLoading||_state == LSPullRefreshNoMore) {
				
	} else if (scrollView.isDragging) {
		
		BOOL _loading = NO;
		
		if (_state == LSPullRefreshPulling && scrollView.contentOffset.y - _contentOffsetY- TRIGGER_DISTANCE < (scrollView.contentSize.height - scrollView.frame.size.height) && !_loading) {
			[self setState:LSPullRefreshNormal];
		} else if (_state == LSPullRefreshNormal && scrollView.contentOffset.y - _contentOffsetY - TRIGGER_DISTANCE > (scrollView.contentSize.height - scrollView.frame.size.height) && !_loading) {
			[self setState:LSPullRefreshPulling];
		}

		
	}
	
}

- (void)lsLoadScrollViewDidEndDragging:(UIScrollView *)scrollView {
    if (_state == LSPullRefreshNoMore) {
        return;
    }
	BOOL _loading = NO;
	if ([_delegate respondsToSelector:@selector(lsLoadTableFooterDataSourceIsLoading:)]) {
		_loading = [_delegate lsLoadTableFooterDataSourceIsLoading:self];
	}
	
	if (scrollView.contentOffset.y - _contentOffsetY - TRIGGER_DISTANCE > (scrollView.contentSize.height - scrollView.frame.size.height) && !_loading &&_state!=LSPullRefreshLoading) {
		if ([_delegate respondsToSelector:@selector(lsLoadTableFooterDidTriggerLoad:)]) {
			[_delegate lsLoadTableFooterDidTriggerLoad:self];
		}
		[self setState:LSPullRefreshLoading];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 50.0f, 0.0f);
        [UIView commitAnimations];
	}
	
}

- (void)lsLoadScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    [UIView commitAnimations];
	[self setState:LSPullRefreshNormal];
}

#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
	_delegate=nil;
	_activityView = nil;
	_statusLabel = nil;
//	_arrowImage = nil;
    [super dealloc];
}

@end
