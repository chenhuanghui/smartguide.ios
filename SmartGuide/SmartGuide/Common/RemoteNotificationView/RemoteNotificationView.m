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

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    midView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_search_mid.png"]];
}

-(IBAction) btnTouchUpInside:(id) sender
{
    [self.delegate remoteNotificationViewTouched:self];
    
    self.userInteractionEnabled=false;
    [self hide];
}

-(void)show
{
    if([self.delegate respondsToSelector:@selector(remoteNotificationWillShow:)])
        [self.delegate remoteNotificationWillShow:self];
    
    self.alpha=0;
    self.hidden=false;
    self.frame=CGRectMake(UIScreenSize().width-38, UIScreenSize().height-38, 38, 38);
    lblMessage.alpha=0;
    lblMessage.text=_noti.message;
    
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha=1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.f animations:^{
            self.frame=CGRectMake(UIScreenSize().width/2, self.l_v_y, UIScreenSize().width/2, 38);
            lblMessage.alpha=1;
            [lblMessage l_v_setW:160-27];
            [imgvRed l_v_setX:7];
        } completion:^(BOOL finished) {
            if([self.delegate respondsToSelector:@selector(remoteNotificationDidShow:)])
                [self.delegate remoteNotificationDidShow:self];
        }];
    }];
}

-(void)hide
{
    if([self.delegate respondsToSelector:@selector(remoteNotificationWillHide:)])
        [self.delegate remoteNotificationWillHide:self];
    
    [UIView animateWithDuration:1.f animations:^{
        self.frame=CGRectMake(UIScreenSize().width-38, self.l_v_y, 38, 38);
        lblMessage.alpha=0;
        lblMessage.layer.frame=CGRectMake(20, 0, 0, 38);
        [imgvRed l_v_setX:15];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5f animations:^{
            self.alpha=0;
        } completion:^(BOOL finished) {
            self.hidden=true;
            
            if([self.delegate respondsToSelector:@selector(remoteNotificationDidHide:)])
                [self.delegate remoteNotificationDidHide:self];
        }];
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
