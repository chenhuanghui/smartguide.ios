//
//  AnnouncementViewController.h
//  SmartGuide
//
//  Created by XXX on 7/15/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ViewController.h"

enum NOTIFICATION_TYPE {
    NOTIFICATION_DEFAULT=0,
    NOTIFICATION_ERROR=1,
    NOTIFICATION_WARNING=2,
};

@class NotificationViewController;

@interface NotificationViewController : UIViewController
{
    __weak IBOutlet UIImageView *imgv;
    __weak IBOutlet UITextView *txtContent;
    enum NOTIFICATION_TYPE _type;
    id delegate;
}

-(NotificationViewController*) initWithType:(enum NOTIFICATION_TYPE) announType withImage:(UIImage*) image withContent:(NSString*) content;
-(void) hide;
-(enum NOTIFICATION_TYPE) type;

@property (nonatomic, assign) bool closedWhenTouched;
@property (nonatomic, assign) NSObject* tag;

@end