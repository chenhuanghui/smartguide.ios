//
//  LoadMoreView.h
//  Infory
//
//  Created by XXX on 8/26/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadMoreView : UIView

-(void) startAnimating;
-(void) stopAnimating;

@property (nonatomic, weak, readonly) UIImageView *imgv;

@end

@interface UIView(LoadMoreView)

@property (nonatomic, weak, readwrite) LoadMoreView *loadMoreView;

-(void) showLoadMore;
-(void) showLoadMoreInRect:(CGRect) rect;
-(void) removeLoadMore;

@end