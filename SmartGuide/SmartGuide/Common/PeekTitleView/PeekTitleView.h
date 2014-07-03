//
//  PeekTitleView.h
//  PeakTitleView
//
//  Created by XXX on 7/2/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PeekTitleView, ScrollPeek;

@protocol PeekTitleViewDelegate <NSObject>

-(void) peekTitleView:(PeekTitleView*) peekView touchedIndex:(int) index;

@end

@interface PeekTitleView : UIView
{
    __weak IBOutlet ScrollPeek *scroll;
    __weak IBOutlet UIView *touchView;
    
    NSMutableArray *_titles;
}

-(void) addTitles:(NSArray*) titles;
-(void) addTitle:(NSString*) title;
-(void)setTitleIndex:(int)index animate:(bool)animate;

@property (nonatomic, weak) id<PeekTitleViewDelegate> delegate;

@end

@interface PeekTouchView : UIView

@property (nonatomic, weak) IBOutlet UIScrollView *receiveView;

@end

@interface ScrollPeek : UIScrollView

@end