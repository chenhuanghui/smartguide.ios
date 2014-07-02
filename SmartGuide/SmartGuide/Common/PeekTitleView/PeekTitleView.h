//
//  PeekTitleView.h
//  PeakTitleView
//
//  Created by XXX on 7/2/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PeekTitleView;

@protocol PeekTitleViewDelegate <NSObject>

-(void) peekTitleView:(PeekTitleView*) peekView touchedIndex:(int) index;

@end

@interface PeekTitleView : UIView
{
    __weak IBOutlet UIScrollView *scroll;
    
    NSMutableArray *_titles;
}

-(void) addTitle:(NSString*) title;

@property (nonatomic, weak) id<PeekTitleViewDelegate> delegate;

@end

@interface PeekTouchView : UIView

@property (nonatomic, weak) IBOutlet UIView *receiveView;

@end