//
//  RemoteNotificationView.h
//  Infory
//
//  Created by XXX on 5/19/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RemoteNotificationView,UserNotification,RemoteNotificationPatternView;

@protocol RemoteNotificationDelegate <NSObject>

-(void) remoteNotificationViewTouched:(RemoteNotificationView*) remoteView;

@optional
-(void) remoteNotificationWillShow:(RemoteNotificationView*) remoteView;
-(void) remoteNotificationDidShow:(RemoteNotificationView*) remoteView;
-(void) remoteNotificationWillHide:(RemoteNotificationView*) remoteView;
-(void) remoteNotificationDidHide:(RemoteNotificationView*) remoteView;

@end

@interface RemoteNotificationView : UIView
{
    __weak IBOutlet UIImageView *imgvLeft;
    __weak IBOutlet UIImageView *imgvRight;
    __weak IBOutlet UIView *midView;
    __weak IBOutlet UILabel *lblMessage;
    __weak IBOutlet UIButton *btnNoti;
    __weak IBOutlet UIImageView *imgvRed;
    
    __strong UserNotification *_noti;
}

-(void) setUserNotification:(UserNotification*) noti;
-(void) show;
-(void) hide;
-(UserNotification*) userNotification;

@property (nonatomic, weak) IBOutlet id<RemoteNotificationDelegate> delegate;

@end