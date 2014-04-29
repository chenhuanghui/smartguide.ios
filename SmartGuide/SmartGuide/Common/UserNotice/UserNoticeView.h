//
//  UserNoticeView.h
//  Infory
//
//  Created by XXX on 4/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserNoticeView;

@protocol UserNoticeDelegate <NSObject>

@optional
-(void) userNoticeDidShowed:(UserNoticeView*) userNoticeView;
-(void) userNoticeDidRemoved:(UserNoticeView*) userNoticeView;

@end

@interface UserNoticeView : UIView
{
    __weak IBOutlet UIView *bgView;
}

-(UserNoticeView*) initWithNotice:(NSString*) notice;

-(void) showUserNoticeWithView:(UIView*) view delegate:(id<UserNoticeDelegate>) delegate;
-(void) removeUserNotice;

@property (nonatomic, weak) IBOutlet UITextView *txt;
@property (nonatomic, weak) id<UserNoticeDelegate> delegate;

@end
