//
//  Scroller.h
//  SmartGuide
//
//  Created by MacMini on 27/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollerDelegate <NSObject>

@end

@interface Scroller : NSObject
{
    __weak UIImageView *_scrollBar;
    __weak UILabel *lbl;
    __weak UIImageView *imgv;
    __weak UIView *view;
    __weak UIView *bgView;
    UIImage *_icon;
    bool _isdidFirstVisible;
}

-(Scroller*) init;

-(void) setIcon:(UIImage*) icon;
-(void) setText:(NSString*) text prefix:(NSString*) prefix;

-(void) scrollViewWillBeginDragging:(UIScrollView*) scrollView;
-(void) scrollViewDidScroll:(UIScrollView*) scrollView;

-(CGPoint) center;
-(UIImageView*) scrollBar;
-(CGSize) size;
-(UIView*) view;

@property (nonatomic, weak) id<ScrollerDelegate> delegate;
@property (nonatomic, assign) bool hidden;

@end
