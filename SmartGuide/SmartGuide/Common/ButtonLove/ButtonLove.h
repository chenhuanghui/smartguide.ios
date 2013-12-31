//
//  ButtonLove.h
//  ButtonLove
//
//  Created by MacMini on 12/12/2013.
//  Copyright (c) 2013 MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@class ButtonLove;

@protocol ButtonLoveDelegate <NSObject>

-(void) buttonLoveTouched:(ButtonLove*) buttonLoveView;

@end

@interface ButtonLove : UIView
{
    __weak IBOutlet UIButton *btnLove;
    __weak IBOutlet UILabel *lblTop;
    __weak IBOutlet UILabel *lblBot;
    __weak IBOutlet UIImageView *imgvLeft;
    __weak IBOutlet UIImageView *imgvRight;
    __weak IBOutlet UIView *midView;
    
    CGRect _leftFrame;
    CGRect _rightFrame;
    CGRect _midFrame;
    CGRect _buttonFrame;
    CGRect _lblTopFrame;
    CGRect _lblBotFrame;
}

-(void) love:(bool) animate;
-(void) unlove:(bool) animate;
-(void) setNumOfLove:(NSString*) numOfLove;
-(void) setLoveStatus:(enum LOVE_STATUS) status withNumOfLove:(NSString*) numOfLove animate:(bool) animate;

@property (nonatomic, assign) enum LOVE_STATUS loveStatus;
@property (nonatomic, weak) id<ButtonLoveDelegate> delegate;

@end
