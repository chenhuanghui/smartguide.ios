//
//  SGScrollView.h
//  SGScrollView
//
//  Created by MacMini on 10/12/2013.
//  Copyright (c) 2013 MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGScrollView : UIScrollView
{
    NSMutableArray *_pauseViews;
    NSMutableArray *_followViews;
    CGPoint _offset;
    
    void(^_completedSetContentOffSetX)();
    float _contentOffsetTargetX;
}

-(CGPoint) offset;

-(void) pauseView:(UIView*) view minY:(float) y;
-(void) followView:(UIView*) view;

-(void) clearFollowViews;
-(void) clearPauseViews;

-(void) setContentOffsetX:(CGPoint)contentOffset animated:(BOOL)animated completed:(void(^)()) completed;

@property (nonatomic, assign) float minimumOffsetY;

@end

@interface PauseView: NSObject

+(PauseView*) pauseViewWithView:(UIView*) view minY:(float) minY;

@property (nonatomic, weak) UIView *view;
@property (nonatomic, assign) float minY;
@property (nonatomic, assign) CGRect viewFrame;

@end

@interface FollowView : NSObject

@property (nonatomic, weak) UIView *view;
@property (nonatomic, assign) CGRect viewFrame;

@end