//
//  RemoteNotificationView.m
//  Infory
//
//  Created by XXX on 5/19/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "RemoteNotificationView.h"
#import "TextFieldSearchBackgroundView.h"
#import "Utility.h"
#import "NotificationManager.h"

@interface RemoteNotificationPatternView : UIView
{
    
}

@end

@implementation RemoteNotificationPatternView

-(void)drawRect:(CGRect)rect
{
    rect.origin=CGPointZero;
    [[UIImage imageNamed:@"bg_search_mid"] drawAsPatternInRect:rect];
}

@end

@implementation RemoteNotificationView

- (instancetype)init
{
    self = [[NSBundle mainBundle] loadNibNamed:@"RemoteNotificationView" owner:nil options:nil][0];
    if (self) {
        
    }
    return self;
}

-(IBAction) btnTouchUpInside:(id) sender
{
    [self.delegate remoteNotificationViewTouched:self];
    
    self.userInteractionEnabled=false;
    [self hide];
}

-(IBAction) btnCloseTouchUpInside:(id)sender
{
    [self.delegate remoteNotificationViewTouchedClose:self];
}

-(void)show
{
    if([self.delegate respondsToSelector:@selector(remoteNotificationWillShow:)])
        [self.delegate remoteNotificationWillShow:self];
    
    [bgView addShadow:1];
    self.alpha=0;
    self.hidden=false;
    [self l_v_setY:-self.l_v_h];
//    [btnNoti setTitle:_noti.message forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.5f animations:^{
        [self l_v_setY:0];
        self.alpha=1;
    } completion:^(BOOL finished) {
        if([self.delegate respondsToSelector:@selector(remoteNotificationDidShow:)])
            [self.delegate remoteNotificationDidShow:self];
    }];
}

-(void)hide
{
    if([self.delegate respondsToSelector:@selector(remoteNotificationWillHide:)])
        [self.delegate remoteNotificationWillHide:self];
    
    [UIView animateWithDuration:0.5f animations:^{
        [self l_v_setY:-self.l_v_h];
        self.alpha=0;
    } completion:^(BOOL finished) {
        if([self.delegate respondsToSelector:@selector(remoteNotificationDidHide:)])
            [self.delegate remoteNotificationDidHide:self];
    }];
}

-(void)setRemoteNotification:(RemoteNotification *)noti
{
    _noti=noti;
}

-(RemoteNotification *)remoteNotification
{
    return _noti;
}

-(void)dealloc
{
    _noti=nil;
}

@end
