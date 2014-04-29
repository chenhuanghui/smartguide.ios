//
//  UserNoticeView.m
//  Infory
//
//  Created by XXX on 4/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "UserNoticeView.h"
#import "Utility.h"

@interface UserNoticeView()<UITextViewDelegate>

@end

@implementation UserNoticeView

-(UserNoticeView *)initWithNotice:(NSString *)notice
{
    self=[[NSBundle mainBundle] loadNibNamed:@"UserNoticeView" owner:nil options:nil][0];

    self.txt.text=notice;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [bgView addGestureRecognizer:tap];
    bgView.userInteractionEnabled=false;
    
    return self;
}

-(void) tap:(UITapGestureRecognizer*) tap
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(userNoticeDidRemoved:)])
        [self.delegate userNoticeDidRemoved:self];
    
    [self removeUserNotice];
}

-(void)showUserNoticeWithView:(UIView *)view delegate:(id<UserNoticeDelegate>)delegate
{
    self.delegate=delegate;
    
    self.alpha=0;
    
    [self l_v_setS:UIScreenSize()];
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha=1;
        bgView.alpha=0.6f;
    } completion:^(BOOL finished) {
        
        [self.txt addShadow:2];
        if(self.delegate && [self.delegate respondsToSelector:@selector(userNoticeDidShowed:)])
            [self.delegate userNoticeDidShowed:self];
        
        bgView.userInteractionEnabled=true;
    }];
}

-(void)removeUserNotice
{
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha=0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
