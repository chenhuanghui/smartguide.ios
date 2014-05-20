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
#import "UserNotification.h"

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

-(void)awakeFromNib1
{
    [super awakeFromNib];
    
    CGRect rect=self.frame;
    rect.origin=CGPointZero;

    UIImageView *imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_search_left.png"]];
    [imgv l_v_setS:CGSizeMake(19, 38)];
    imgv.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin;
    
    [self addSubview:imgv];
    
    imgvLeft=imgv;
    
    RemoteNotificationPatternView *view=[[RemoteNotificationPatternView alloc] init];
    [view l_v_setH:38];
    view.contentMode=UIViewContentModeRedraw;
    view.autoresizesSubviews=false;
    view.backgroundColor=[UIColor clearColor];
    view.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin;
    
    [self addSubview:view];
    
    midView=view;
    
    imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_search_right.png"]];
    [imgv l_v_setS:CGSizeMake(19, 38)];
    imgv.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin;
    
    [self addSubview:imgv];
    
    imgvRight=imgv;
    
    imgv=[[UIImageView alloc] initWithFrame:rect];
    imgv.contentMode=UIViewContentModeCenter;
    imgv.image=[UIImage imageNamed:@"icon_alertnotice.png"];
    [imgv l_v_setW:8];
    
    [self addSubview:imgv];
    
    imgvRed=imgv;
    
    UILabel *lbl=[[UILabel alloc] initWithFrame:rect];
    [self addSubview:lbl];
    
    lblMessage=lbl;
    
    UIButton *btn=[[UIButton alloc] initWithFrame:rect];
    [btn addTarget:self action:@selector(btnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor=[UIColor clearColor];
    
    [self addSubview:btn];
    
    btnNoti=btn;
}

-(IBAction) btnTouchUpInside:(id) sender
{
    [self.delegate remoteNotificationViewTouched:self];
    
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

-(void)show1
{
    if([self.delegate respondsToSelector:@selector(remoteNotificationWillShow:)])
        [self.delegate remoteNotificationWillShow:self];
    
    self.frame=CGRectMake(UIScreenSize().width-38, self.l_v_y, 38, self.l_v_h);
    self.alpha=0;
    [imgvRed l_v_setX:(self.l_v_w-8)/2];
    lblMessage.text=_noti.content;
    lblMessage.alpha=0;
    self.hidden=false;
    
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha=1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.f animations:^{
            CGSize screenSize=UIScreenSize();
            self.frame=CGRectMake(screenSize.width/2, self.l_v_y, screenSize.width/2, self.l_v_h);
            lblMessage.alpha=1;
        } completion:^(BOOL finished) {
            
            if(finished && [self.delegate respondsToSelector:@selector(remoteNotificationDidShow:)])
                [self.delegate remoteNotificationDidShow:self];
        }];
    }];
}

-(void)hide1
{
    if([self.delegate respondsToSelector:@selector(remoteNotificationWillHide:)])
        [self.delegate remoteNotificationWillHide:self];
    
    [UIView animateWithDuration:1.f animations:^{
        self.frame=CGRectMake(UIScreenSize().width-38, self.l_v_y, 38, self.l_v_h);
        lblMessage.alpha=0;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5f animations:^{
            self.alpha=0;
        } completion:^(BOOL finished) {
            if([self.delegate respondsToSelector:@selector(remoteNotificationDidHide:)])
                [self.delegate remoteNotificationDidHide:self];
        }];
    }];
}

-(void)setFrame1:(CGRect)frame
{
    [super setFrame:frame];
    
    frame.origin=CGPointZero;

    [imgvLeft l_v_setX:0];
    [midView l_v_setX:19];
    [midView l_v_setW:frame.size.width-19*2];
    [imgvRight l_v_setX:frame.size.width-19];
    [btnNoti l_v_setS:frame.size];
    
    frame.origin.x=10;
    frame.origin.y=0;
    
    [imgvRed l_v_setO:frame.origin];
    
    frame.origin.x=20;
    frame.origin.y=0;
    frame.size.width-=frame.origin.x*2;

    lblMessage.frame=frame;
}

-(void)setUserNotification:(UserNotification *)noti
{
    _noti=noti;
}

-(UserNotification *)userNotification
{
    return _noti;
}

-(void)dealloc
{
    _noti=nil;
}

@end
