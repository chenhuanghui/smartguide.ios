//
//  RemoteNotificationView.h
//  Infory
//
//  Created by XXX on 5/19/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RemoteNotificationView,RemoteNotification,RemoteNotificationPatternView;

@protocol RemoteNotificationDelegate <NSObject>

-(void) remoteNotificationViewTouched:(RemoteNotificationView*) remoteView;
-(void) remoteNotificationViewTouchedClose:(RemoteNotificationView*) remoteView;

@optional
-(void) remoteNotificationWillShow:(RemoteNotificationView*) remoteView;
-(void) remoteNotificationDidShow:(RemoteNotificationView*) remoteView;
-(void) remoteNotificationWillHide:(RemoteNotificationView*) remoteView;
-(void) remoteNotificationDidHide:(RemoteNotificationView*) remoteView;

@end

@interface RemoteNotificationView : UIView
{
    __weak IBOutlet UIButton *btnNoti;
    __weak IBOutlet UIView *bgView;
    
    __strong RemoteNotification *_noti;
}

-(void) setRemoteNotification:(RemoteNotification*) noti;
-(void) show;
-(void) hide;
-(RemoteNotification*) remoteNotification;

@property (nonatomic, weak) IBOutlet id<RemoteNotificationDelegate> delegate;

@end